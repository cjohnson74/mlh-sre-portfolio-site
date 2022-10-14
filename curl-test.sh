#!/bin/bash

curl http://localhost:5000/api/timeline_post

curl -X POST http://localhost:5000/api/timeline_post -d 'name=Carson&email=carson.johnson@gmail.com&content=Just Tested API for my portfolio site!'

curl http://localhost:5000/api/timeline_post


#Below is Bonus Delete [NOT WORKING YET]
#NUM_OF_POSTS=$( curl http://localhost:5000/api/timeline_post > wc -l )

#curl -X DELETE http://localhost:5000/api/timeline_post?id=$NUM_OF_POSTS
