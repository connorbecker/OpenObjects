/*
    This file is a part of OpenObjects.
    Copyright (C) 2015  C. Northcott Becker

    OpenObjects is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#import "MutableString.h"

@implementation MutableString
-(id) add: (String*)toAdd
{
	char* temp = [toAdd asCString];
	[self addCString: temp];
	free(temp);
	return self;
}
-(id) write: (String*)toWrite
{
	return [self add: toWrite];
}
-(id) addChar: (char)toAdd
{
	//this isn't going to be efficient, IDT...
	if(toAdd == '\0') return self; //this gets around the potential of having multiple null chars at the end
	char* temp = malloc((len + 2) * sizeof(char));
	strcpy(temp, c_string);
	temp[len + 1] = toAdd;
	temp[len + 2] = '\0';
	free(c_string);
	c_string = temp;
	len = len + 1;
	return self;
}
-(id) writeChar: (char)lastChar
{
	return [self addChar: lastChar];
}
-(id) addCString: (char*)toAdd
{
	char* temp;
	len = len + strlen(toAdd);
	temp = malloc((len + 1) * sizeof(char));
	strcpy(temp, c_string);
	strcat(temp, toAdd);
	free(c_string);
	c_string = temp;	
	return self;
}
-(id) replace: (String*)example With: (String*)replacement
{
	int pos = [self find: example];
	if(pos == -1) return self;
	int pre_len = len - pos;
	int post_len = len - pos - [example length];
	char* c_toreturn = malloc((pre_len + post_len + [replacement length] + 1) * sizeof(char));
	strcpy(c_toreturn, c_string);	//this puts the current string in the buffer
	c_toreturn[pre_len] = '\0'; 	//this may be off by 1
	char* temp = [replacement asCString];
	strcat(c_toreturn, temp);	//this writes the replacement string at the end of pre-example portion
	free(temp);
	temp = c_string + post_len;	//this may be off by 1
	strcat(c_toreturn, temp);	//this puts the post-example portion into the new string
	free(c_string);
	c_string = c_toreturn;		//replaces the current c_string with the new one
	len = pre_len + [replacement length] + post_len; //this may be off by 1
	return self;
}
-(id) replaceAll: (String*)example With: (String*)replacement
{
	int pos = 0, pre_len, post_len, ex_len = [example length], rep_len = [replacement length];
	char* c_toreturn, *temp, *rep_string = [replacement asCString];
	while((pos = [self find: example After: pos]) != -1)	//making this after the last position stops some possible cycles
	{
		pre_len = len - pos;
		post_len = len - pos - ex_len;
		c_toreturn = malloc((pre_len + post_len + rep_len + 1) * sizeof(char));
		strcpy(c_toreturn, c_string);	//this puts the current string in the buffer
		c_toreturn[pre_len] = '\0'; 	//this may be off by 1
		temp = rep_string;
		strcat(c_toreturn, temp);	//this writes the replacement string at the end of pre-example portion
		free(temp);
		temp = c_string + post_len;	//this may be off by 1
		strcat(c_toreturn, temp);	//this puts the post-example portion into the new string
		free(c_string);
		c_string = c_toreturn;		//replaces the current c_string with the new one
		len = pre_len + rep_len + post_len; //this may be off by 1
		pos = pos + rep_len;	//may be off by 1
	}
	free(rep_string);
	return self;
}
-(id) toUppercase
{
	int i;
	for(i = 0; i < len; i = i + 1)
	{
		c_string[i] = toupper(c_string[i]);
	}
	return self;
}
-(id) toLowercase
{
	int i;
	for(i = 0; i < len; i = i + 1)
	{
		c_string[i] = tolower(c_string[i]);
	}
	return self;
}
@end
