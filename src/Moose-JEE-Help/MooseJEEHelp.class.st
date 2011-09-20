Class {
	#name : #MooseJEEHelp,
	#superclass : #CustomHelp,
	#category : #'Moose-JEE-Help'
}

{ #category : #pages }
MooseJEEHelp class >> Introduction [
	"This method was automatically generated. Edit it using:"
	"MooseJEEHelp edit: #Introduction"
	^HelpTopic
		title: 'Introduction'
		contents: 
'MooseJEE is an extension of Moose, the platform for software and data analysis, to support the analysis of heterogenous applications.

With heterogenous applications we mean an application that is composed of multiple languages or technologies. A typical example of heterogenous applications are Java Enterprise applications.

Several meta-models, analyses and importers are already included in MooseJEE. All of them can be extended and more can be crafted by using tools like PetitParser or Mondrian.!' readStream nextChunkText
]

{ #category : #pages }
MooseJEEHelp class >> License [
	"This method was automatically generated. Edit it using:"
	"MooseJEEHelp edit: #License"
	^HelpTopic
		title: 'License'
		contents: 
'Licensed under the BSD License with parts under the MIT License.

Copyright (c) 2008-2011 Fabrizio Perin and MooseJEE Contributors

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

================================================================

To learn more about Moose, its tools and its license go to
http://www.moosetechnology.org/

Based on Pharo 1.4
http://pharo-project.org!' readStream nextChunkText
]

{ #category : #accessing }
MooseJEEHelp class >> bookName [ 
	^'Moose JEE'
]

{ #category : #accessing }
MooseJEEHelp class >> icon [
	^HelpIcons iconNamed: #packageIcon
]

{ #category : #accessing }
MooseJEEHelp class >> pages [
	^#(Introduction License)
]
