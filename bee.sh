#!/bin/bash
#
# Copyright 2010 Tom White
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

function speak {
  echo "$@" > /tmp/speak
  espeak -v en-uk -s 120 -f /tmp/speak --stdout | aplay -q
}

while true; do
  # read out a random word
  word=$(sort -R words | head -1)
  speak "How do you spell, $word"

  # wait for keypress
  echo "Press a key for the answer"
  read -n 1 -s

  # spell it out
  letters=$(echo $word | tr '[A-Z]' '[a-z]' | sed 's/[a-z]/&, /g')
  echo $word
  echo $letters
  speak $letters

  # wait for keypress
  echo "Press a key for the next word"
  read -n 1 -s

done
