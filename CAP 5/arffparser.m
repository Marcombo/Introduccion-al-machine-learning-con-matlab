function out = arffparser(mode, fileName, inputStruct, relationName, ...
    cmmnts)
%ARFFPARSER READS OR WRITES AN ARFF FILE
%   OUT = ARFFPARSER(MODE, FILENAME, INPUTSTRUCT, RELATIONNAME, CMMNTS)
%   Reads (in MODE 'read') or writes (in MODE 'write') an .arff file with
%   file name FILENAME into OUT or from INPUTSTRUCT. 
%
%   In read mode, struct's field names are taken from attribute names with
%   struct's naming equal to WEKA's relation name. FILENAME can be either
%   relative path or absolute path.
%
%   In write mode, attribute names and values are taken from the
%   INPUTSTRUCT. INPUTSTRUCT must have the following form:
%
%                                  --> KIND   (INPUTSTRUCT.ATTRIBUTE.KIND)
%   INPUTSTRUCT ---> ATTRIBUTE --->|
%                                  --> VALUES (INPUTSTRUCT.ATTRIBUTE.VALUE)
%
%   In the ATTRIBUTE field are listed all the attributes. Their
%   corresponding kind is in the KIND field. KIND field can have the
%   following values:
%
%     - 'Numeric', for numeric attributes
%     - 'String', for string attributes
%     - 'Date' for using the default date format
%        (other timestamp formats will be included in upcoming versions)
%     - a vector or cell array (for strings) for nominal values
%
%   Support for string and date attributes will be included in upcoming
%   versions.
%
%   When in read mode, RELATIONNAME, INPUSTRUCT and CMMNTS arguments can be
%   ommited. 
%
%   CMMNTS argument can only be a cell array whos each row is a line to be
%   entered as a comment at the very start of the arff file. The '%'
%   character needs NOT to be included in the cell array (although 
%   inclusion of that character will not regarder as error). This argument
%   is optional.
%
%   String arguments and struct's strings are not case sensitive. 
%
%   -----------------------------------------------------------------------
%
%   EXAMPLES:
%
%   **************************
%   ******* Write mode *******
%
%     >> a = struct('attributes', []);
%
%     >> a.attribute1.kind = 'Numeric';
%     >> a.attribute1.values = 1.234e5;
%     >> a.attribute1.values(2) = 5.678e9;
%           (or a.attribute1.values = [1.234e5 5.678e9];)
%
%     >> a.attribute2.kind = [1 2 3 4];
%     >> a.attribute2.values = 3;
%     >> a.attribute2.values(2) = 4;
%           (or a.attribute2.values = [3 4];)
%
%     >> a.attribute3.kind = 'string';
%     >> a.attribute3.values{1} = 'test1';
%     >> a.attribute3.values{2} = 'test2';
%           (or a.attribute3.values = {'test1' 'test2'};)
%
%     >> arffparser('write', 'testFile', a, 'test relation');
%
%   NOTE BOLD the explicit indication of the cell array when string
%   attributes are used!!!
%
%   The above will create the testfile.arff file which will have the "test
%   relation" WEKA's relation and attributes (in order of appearance): 
%
%   @ATTRIBUTE attribute1 NUMERIC
%   @ATTRIBUTE attribute2 {1 2 3 4}
%   @AttrIBUTE attribute3 string
%
%
%   *************************
%   ******* Read mode *******
%
%     >> a = arffparser('read', 'test');
%
%   If 'test' file is the file created in the previous example, then struct
%   a will have the form:
%
%     attribute1: [1x1 struct]
%     attribute2: [1x1 struct]
%     attribute3: [1x1 struct]
%
%   And etc...
%
%   -----------------------------------------------------------------------
%
%   Authors: Konstantinos Drossos, Dr. Andreas Floros
% 
%   Affiliation: Ionian University, Dept of Audiovisual Arts, Corfu, Greece
%
%   Version: 2.0 
%
%   For bus and needed features, please email to: 
% 
%                  <a href="mailto:kdrosos@ionio.gr";">kdrosos@ionio.gr</a>
%
%   Date: 22/11/2012 (dd-mm-yyyy)
%
%   -----------------------------------------------------------------------
    

    % Check if mode is string
    if ~isa(mode, 'char')
        error('ERROR:ARFFPARSER','Mode argument must be a string');
    end
    
    % Make mode's argument characters lower case
    mode = lower(mode);
    
    % Check the mode and the input arguments
    if ~strcmp(mode, 'read') && ~strcmp(mode, 'write')
        error('ERROR:ARFFPARSER',...
            'Mode argument must be either ''read'' or ''write''');
    end
    
    % The READ mode
    if strcmp(mode, 'read')
        
        % Initial checks
        if nargin < 2
            error('ERROR:ARFFPARSER', 'Too few input arguments');
        end
        
        if nargin > 2
            warning('WARNING:ARFFPARSER',...
                'Extra arguments will be ommited');
        end
        
        try
            if isempty(strfind(fileName, '.arff'))
                fileName = [fileName '.arff'];
            end
            
            fid = fopen(fileName, 'r');
            
            if fid == -1
                error('ERROR:ARFFPARSER', 'File could not be opened')
            end
            
        catch ME
            error('ERROR:ARFFPARSER', 'File not found');
        end

        % Read the file
        theText = textscan(fid, '%s', 'delimiter', '\n');
        theText = theText{1};
        
        % Remove empty lines
        theText = theText(~cellfun(@isempty, theText));
        
        % Make all letters low case
        theText = lower(theText);
        
        % Check if there is a relation naming in the arff file
        if isempty(strfind(theText, '@relation'))
            error('ERROR:ARFFPARSER', ...
                'Not valid relation naming in .arff file');
        end

        % Get only the lines after the relation declaration
        theText = theText(find(~cellfun(@isempty, ...
            strfind(theText, '@relation')) == 1) : length(theText));
        
        tmpVar = {};
        
        % Strip off comments
        for indx = 1:length(theText)
            tmpVar2 = theText{indx};
            if ~strcmp(tmpVar2(1), '%')
                tmpVar{length(tmpVar) + 1, 1} = tmpVar2;
            end
        end
        
        theText = tmpVar;
        
        clear tmpVar;
        
        % Break up the text in two regions
        textAttr = theText(2:( find(~cellfun(@isempty, ...
            strfind(theText, '@data')) == 1) - 1));
        
        textVals = theText(( find(~cellfun(@isempty, ...
            strfind(theText, '@data')) == 1) +1):length(theText));
        
        % Close the file
        fclose(fid);
        
        % Clear unwanted variables
        clear theText;
        clear fid;
        
        % For each line of the attributes text
        for indx = 1:length(textAttr)
            
            % Get the kind of the attribute based on the ending latter
            endingLetter = textAttr{indx}(length(textAttr{indx}));
            
            % Find the starting index of the attribute's name and values
            % (if any)
            
            % Numeric or real attributes
            if strcmp(endingLetter, 'c') || strcmp(endingLetter, 'l')
                
                % Get the defined kind
                if strcmp(endingLetter, 'l')
                    nameStr = 'real';
                else
                    nameStr = 'numeric';
                end                
                
                % Assing values, treating real as numeric
                theKind = 'numeric';
                strKind = 'numeric';
                
                % Assign indices
                indxEnd = length(textAttr{indx}) - length(nameStr);
                indxStart = length('@attribute') + 1;
                
                % Clear unwanted variables
                clear nameStr;
                
            elseif strcmp(endingLetter, '}') % Nominal attributes
                
                % Indicate the kind of the attribute
                theKind = 'nominal';

                % Find the values for the nominal attribute
                indxEnd = strfind(textAttr{indx}, '}') - 1;
                indxStart = strfind(textAttr{indx}, '{') + 1;
                strKind = textAttr{indx};
                strKind = strKind(indxStart:indxEnd);

                % Find the indices for the name of the attribute
                indxStart = length('@attribute') + 1;
                indxEnd = strfind(textAttr{indx}, '{') - 1;
                
            elseif strcmp(endingLetter, 'g') % String attributes
                
                strKind = 'string';
                indxEnd = length('string') + 1;
                indxStart = length('@attribute ') + 1;
                
            elseif strcmp(endingLetter, 'e') % Date attributes
                
                theKind = 'date';
                strKind = 'date';
                indxEnd = length('date') + 1;
                indxStart = length('@attribute ') + 1;
                
            else
                
                q = 'No appropriate kind of attribute';
                error('ERROR:ARFFPARSER',q)
                
            end
            
            % Clear unwanted variables
            clear endingLetter;
            
            % Get the current string
            tmpStr = textAttr{indx};
            
            % Check for spaces and make indices point to no space chars
            while isspace(tmpStr(indxStart))
                indxStart = indxStart + 1;
            end
            
            while isspace(tmpStr(indxEnd))
                indxEnd = indxEnd - 1;
            end
            
            % Check if there are any quote marks and remove them
            if strcmp(textAttr{indx}(indxStart), '"') || ...
                    strcmp(textAttr{indx}(indxStart), '''')
                
                % And if it is increase the index for starting of the name
                indxStart = indxStart +1;
            end
            
            if strcmp(textAttr{indx}(indxEnd), '"') || ...
                    strcmp(textAttr{indx}(indxEnd), '''')
                
                % And if it is decrease the index for ending of the name
                indxEnd = indxEnd - 1;
            end            
            
            % Get the name of the attribute
            strName = textAttr{indx}(indxStart:indxEnd);
            
            % Remove spaces from name
            strName = strName(~isspace(strName));
            
            % Remove punctuation chars
            strName(isstrprop(strName, 'punct')) = [];
            
            % Remove non alphanumeric chars
            strName(~isstrprop(strName, 'alphanum')) = '_';
            
            % Add the attribute to the output struct
            if strcmp(theKind, 'numeric')
                try
                    eval(['out.' strName '.kind =''' strKind ''';']);
                catch me
                    disp('OK')
                end
            elseif strcmp(theKind, 'nominal')
                if isstrprop(strKind(1), 'digit')
                    eval(['out.' strName '.kind = [str2num(strKind)];']);
                else
                    
                    % Check if there are single quotes for the string
                    % argument
                    
                    % Check if the first character is singe quote
                    if ~strcmp(strKind(1), '''')
                        strKind = ['''' strKind];
                    end
                    
                    % Then check position of commas
                    commaInds = strfind(strKind, ',');
                    
                    % Then check for the rest characters and insert single
                    % quote wherever is needed
                    for indx2 = 1:length(commaInds)
                        
                        if ~strcmp(strKind(commaInds(indx2) - 1), '''')
                            
                            strKind = [strKind(1:commaInds(indx2)-1) ...
                                '''' strKind(commaInds(indx2):...
                                length(strKind))];
                            
                            % If something is inserted, get again the
                            % position of commas
                            commaInds = strfind(strKind, ',');
                            
                        end
                        
                        if ~strcmp(strKind(commaInds(indx2) + 1), '''')
                            
                            strKind = [strKind(1:commaInds(indx2)) ...
                                '''' strKind(commaInds(indx2) + 1:...
                                length(strKind))];
                            
                            % If something is inserted, get again the
                            % position of commas
                            commaInds = strfind(strKind, ',');
                            
                        end
                        
                    end
                    
                    % Then check for the last one
                    if ~strcmp(strKind(length(strKind)), '''')
                        strKind = [strKind ''''];
                    end
                    
                    try
                        eval(['out.' strName '.kind = {' strKind '};']);
                    catch me
                        disp('OK')
                    end
                end
            end
            
            % Check the values' kind of the current attribute
            if strcmp(theKind, 'numeric')
                
                kindType = 'digit';
                tmpVal = [];
                
            elseif strcmp(theKind, 'nominal')
                
                tmpStr = textVals{1};
                commaInds = strfind(tmpStr, ',');
                
                switch indx
                    case 1
                        tmpStrIndx = 1;
                    case length(textAttr)
                        tmpStrIndx = commaInds(length(commaInds)) + 1;
                    otherwise
                        tmpStrIndx = commaInds(indx-1) + 1;
                end
                
                if isstrprop(tmpStr(tmpStrIndx), 'alpha') || ...
                        isstrprop(tmpStr(tmpStrIndx), 'punct')
                    kindType = 'string';
                    tmpVal = {};
                elseif isstrprop(tmpStr(tmpStrIndx), 'digit')
                    kindType = 'digit';
                    tmpVal = [];
                end
                
            elseif strcmp(theKind, 'date')
                
                kindType = 'string';
                tmpVal = {};
                
            elseif strcmp(theKind, 'string')
                
                kindType = 'string';
                tmpVal = {};
                
            end
            
            % Get the values for that attribute
            for indx2 = 1:length(textVals)

                % Get the instance string in a variable
                tmpStr = textVals{indx2};
                
                % Remove spaces (if any)
                tmpStr = tmpStr(~isspace(tmpStr));
                
                % Remove commas taken as strings (in single or double
                % quotes, e.g. , 'a string, with a comma' or "a string,
                % with a comma"
                foundSingleQuote = false;
                for indx3 = 1:length(tmpStr)
                    if strcmp(tmpStr(indx3), '''')
                        foundSingleQuote = true;
                    end

                    if foundSingleQuote && ...
                            strcmp(tmpStr(indx3), '''')
                        foundSingleQuote = false;
                    end

                    if strcmp(tmpStr(indx3), ',') && ...
                        foundSingleQuote
                        tmpStr(indx3) = '_';
                    end
                end
                
                foundSingleQuote = false;
                for indx3 = 1:length(tmpStr)
                    if strcmp(tmpStr(indx3), '"')
                        foundSingleQuote = true;
                    end

                    if foundSingleQuote && ...
                            strcmp(tmpStr(indx3), '"')
                        foundSingleQuote = false;
                    end

                    if strcmp(tmpStr(indx3), ',') && ...
                        foundSingleQuote
                        tmpStr(indx3) = '_';
                    end
                end
                
                % Determine when a new value occurs in the string.
                % Get the positions of comma characters
                commaInds = strfind(tmpStr, ','); 
                
                % Read the values from the text string according to value's
                % index
                if indx == 1
                    
                    % Get from the string the first numeric variable
                    tmpVal2 = tmpStr(1:commaInds(indx)-1);
                    
                    if strcmp(kindType, 'digit')
                        
                        % Check for missing values
                        if strcmp(tmpVal2, '?')
                            tmpVal2 = 'NaN';
                        end
                        
                        % Assing the value
                        tmpVal = [tmpVal str2num(tmpVal2)];
                      
                    elseif strcmp(kindType, 'string')
                      
                        % Check and remove the first quote (if any)
                        if strcmp(tmpVal2(1), '''') || ...
                                strcmp(tmpVal2(1), '"')
                            tmpVal2(1) = [];
                        end
                        
                        % Check and remove the last quote (if any)
                        if strcmp(tmpVal2(length(tmpVal2)), '''') || ...
                                strcmp(tmpVal2(length(tmpVal2)), '"')
                            tmpVal2(length(tmpVal2)) = [];
                        end
                        
                        if strcmp(tmpVal2, '?')
                            tmpVal2 = 'NaN';
                        end
                        
                        tmpVal{indx2} = tmpVal2;
                    end
                elseif indx == length(textAttr)
                    
                    % Get from string the proper values
                    tmpVal2 = tmpStr(commaInds(length(commaInds))...
                            + 1 : length(tmpStr));
                    
                    if strcmp(kindType, 'digit')
                        
                        % Check for missing values
                        if strcmp(tmpVal2, '?')
                            tmpVal2 = 'NaN';
                        end
                        
                        % Get from the string the last numeric variable
                        tmpVal = [tmpVal str2num(tmpVal2)];

                    elseif strcmp(kindType, 'string')
                        
                        % Check and remove the first quote (if any)
                        if strcmp(tmpVal2(1), '''') || ...
                                strcmp(tmpVal2(1), '"')
                            tmpVal2(1) = [];
                        end
                        
                        % Check and remove the last quote (if any)
                        if strcmp(tmpVal2(length(tmpVal2)), '''') || ...
                                strcmp(tmpVal2(length(tmpVal2)), '"')
                            tmpVal2(length(tmpVal2)) = [];
                        end
                        
                        if strcmp(tmpVal2, '?')
                            tmpVal2 = 'NaN';
                        end
                        
                        tmpVal{indx2} = tmpVal2;
                    end
                    
                else
                    
                    % Get from string the proper values
                    tmpVal2 = tmpStr(commaInds(indx-1) + 1:...
                        commaInds(indx) - 1);
                    
                    if strcmp(kindType, 'digit')
                        
                        % Check for missing values
                        if strcmp(tmpVal2, '?')
                            tmpVal2 = 'NaN';
                        end
                      
                        % Get from the string the appropriate numeric
                        % variable
                        tmpVal = [tmpVal str2num(tmpVal2)];
                        
                    elseif strcmp(kindType, 'string')
                        
                        % Check and remove the first quote (if any)
                        if strcmp(tmpVal2(1), '''') || ...
                                strcmp(tmpVal2(1), '"')
                            tmpVal2(1) = [];
                        end
                        
                        % Check and remove the last quote (if any)
                        if strcmp(tmpVal2(length(tmpVal2)), '''') || ...
                                strcmp(tmpVal2(length(tmpVal2)), '"')
                            tmpVal2(length(tmpVal2)) = [];
                        end
                        
                        if strcmp(tmpVal2, '?')
                            tmpVal2 = 'NaN';
                        end
                        
                        tmpVal{indx2} = tmpVal2;
                        
                    end
                end
            end
            
            eval(['out.' strName '.values = tmpVal ;'])
        end
        
    % The WRITE mode
    else
        
        % Check if the filename has the .arff extension
        if ~strcmpi(fileName, '.arff')
            fileName = strcat(fileName, '.arff');
        end
        
        % Create the file
        fid = fopen(fileName, 'w');
        
        % Check if the relation's name has the @ character
        if ~strcmpi(relationName(1), '@')
            relationName = ['@RELATION ', relationName];
        end
        
        if nargin == 5
        
            % String for the warning functionality used just below
            q = 'Comments must be in a vector cell array of strings';

            % Check if comments are cell string
            if isvector(cmmnts)

                if iscellstr(cmmnts)

                    for indx = 1:length(cmmnts)
                        fprintf(fid, '%% %s\n', cmmnts{indx});
                    end

                    fprintf(fid, '\n');

                else
                    warning('WARNING:ARFFPARSER',q);
                end

            else
                warning('WARNING:ARFFPARSER',q);
            end
        end
        
        % Print to file the relation's name
        fprintf(fid, '%s', relationName);
        
        % And insert two new lines
        fprintf(fid, '\n\n');
        
        % Get the attributes
        attrs = fieldnames(inputStruct);
            
        % Create a cell array to hold the values for each instance
        cellValues = {};
        
        % And for each attribute start filling the attributes' name fields
        for indx = 1:length(attrs)
            
            % Construct the string to print to the file
            strForFile = ['@ATTRIBUTE "', attrs{indx}, '" '];
            
            % Get the sub struct for processing
            structToProcess = inputStruct.(attrs{indx});
            
            % Get its fields' names
            tmpFields = fieldnames(structToProcess);
            
            % Check if the current attribute has fields
            if isempty(tmpFields)
                q = ['Attribute''s ' attrs{indx} 'fileds not exist'];
                error('ERROR:ARFFPARSER', q)
            end
            
            % Get the kind of the attribute
            try
                theKind = tmpFields{find(strcmpi(tmpFields, 'kind'))==1};
                theKind = structToProcess.(theKind);
            catch me
                q = ['No kind field in ' attrs{indx}];
                error('ERROR:ARFFPARSER', q)
            end
            
            if ischar(theKind)
                
                theKind = lower(theKind);
                switch theKind
                    case 'numeric'
                        strForFile = [strForFile, 'NUMERIC'];
                    case 'string'
                        strForFile = [strForFile, 'STRING'];
                    case 'date'
                        strForFile = [strForFile, ...
                            'DATE "yyyy-MM-dd HH:mm:ss"'];
                end
            else
                
                if isvector(theKind)
                    
                    if (isnumeric(theKind))
                        
                        theKind = num2str(theKind);
                        theKind = theKind(~isspace(theKind));
                        strForFile = [strForFile, ' {'];
                        
                        for indx2 = 1:length(theKind)
                            
                            strForFile = [strForFile theKind(indx2)];
                            
                            if (indx2 ~= length(theKind))
                                
                                strForFile = [strForFile ','];
                                
                            end
                            
                        end
                        
                        strForFile = [strForFile '}'];
                        
                    elseif (iscellstr(theKind))
                        
                        strForFile = [strForFile '{'];
                        
                        for indx2 = 1:length(theKind)
                            
                            theKind{indx2} = ...
                                theKind{indx2}(~isspace(theKind{indx2}));
                            
                            strForFile = [strForFile '''' ...
                                theKind{indx2} ''''];
                            
                            if (indx2 ~= length(theKind))
                                
                                strForFile = [strForFile ','];
                                
                            end
                            
                        end
                        
                        strForFile = [strForFile '}'];
                        
                    else
                        q = ['Nominal number input must be ' ...
                            'either numberic vector ' ...
                            'or cell string vector'];
                        error('ERROR:ARFFPARSER', q)
              
                    end
                else
                    error('ERROR:ARFFPARSER', ...
                        'Nominal input should be a vector');
                end
            end
            
            cellAttributes{indx} = strForFile;
            
            % Get the values
            try
                theValues = tmpFields{strcmpi(tmpFields, 'values')};
                theValues = structToProcess.(theValues);
            catch me
                q = ['No values field in ' attrs{indx}];
                error('ERROR:ARFFPARSER', q)
            end
            
            if ~isvector(theValues)
                q = ['Values must be in a numeric or cell string ' ...
                    'vector'];
                error('ERROR:ARFFPARSER', q);
            end
            
            % Add the value for each instance
            for indx2 = 1:length(theValues)
                if isvector(theValues)
                    if isnumeric(theValues)
                        if ~isnan(theValues(indx2))
                            cellValues{indx2, indx} = ...
                                num2str(theValues(indx2), '%G');
                        else
                            cellValues{indx2, indx} = '?';
                        end
                    elseif iscellstr(theValues)
                        if ~strcmp(theValues{indx2}, 'NaN')
                            cellValues{indx2, indx} = ...
                                ['''' theValues{indx2} ''''];
                        else
                            cellValues{indx2, indx} = '?';
                        end
                    end
                end
            end
        end
        
        finalValues = cell(size(cellValues, 1), 1);
        
        % Add comma character to values cell
        for indx = 1:size(cellValues, 1)
            
            tmpStr = [];
            
            for indx2 = 1:size(cellValues, 2)
                tmpStr = [tmpStr cellValues{indx, indx2}];
                if (indx2 ~= size(cellValues, 2))
                    tmpStr = [tmpStr ','];
                end
            end
            
            finalValues{indx} = tmpStr;
            
        end
        
        % Print the attributes part
        cellfun(@(x) fprintf(fid, '%s\n', x), cellAttributes);
        
        fprintf(fid, '\n');
        
        % Print the data part
        fprintf(fid, '@DATA\n');
        
        cellfun(@(x) fprintf(fid, '%s\n', x), finalValues);
        
        fprintf(fid, '\n');
        fprintf(fid, '%% .arff file created with arffparser.m');
        
        fclose(fid);
        
        out = 1;
    end
end