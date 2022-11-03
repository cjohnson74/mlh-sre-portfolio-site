# Site Reliability Engineering - Week 1 - Portfolio Site

Welcome to the MLH Fellowship! During Week 1, you'll be working with Flask to build a portfolio site. This site will be the foundation for activities we do in future weeks so spend time this week making it your own and reflect your personality!

## Technologies

### Set Up Nginx and HTTPS
Architecture and network traffic flow before nginx:
![image](https://user-images.githubusercontent.com/52815609/199749647-a9c56de6-1148-4b3b-809c-be8810198107.png)
It is common for production workloads to include a reverse proxy to sit in front of the web server like so:
![image](https://user-images.githubusercontent.com/52815609/199749926-2f17c71d-7f8c-4f48-b43a-fa514d194c1d.png)
There are a number of benefits of having a reverse proxy which includes: Load balancing, SSL termination, Logging, Access control, and more! I am mainly using this for SSL termination at this time which means HTTPS traffic is decrypted and encrypted inside the Nginx container. The Nginx container then communicates with the Flask container over HTTP.

### Added Nginx Service to docker-compose.prod.yml
I created an nginx container that handles automatic SSL certificate generation and serves traffic using HTTPS for me. I used a ready-made docker image jonasal/nginx-certbot. You can learn more about it on [Dockerhub](https://hub.docker.com/r/jonasal/nginx-certbot).
![image](https://user-images.githubusercontent.com/52815609/199750396-fd228da7-4df3-4052-8d26-ed4ec95d1c26.png)

Note I removed the port mapping 5000:5000 from the myportfolio container because internet traffic will now go through nginx which will relay traffic to the myportfolio (Flask) container.

Line 21: Define nginx container

Line 25: Required environment variable to generate certificates

Line 27-29: Bind HTTP and HTTPS ports to the internet

Line 31: Store generated certificate files in a volume so they are not lost upon restart

Line 32: Map nginx configuration files under the directory user_conf.d into the container.

Line 38: Define a named volume nginx_secrets

If you'd like to learn more about how this docker container image works behind the scenes, I recommend checking out their GitHub [README](https://github.com/JonasAlfredsson/docker-nginx-certbot#more-resources), specifically, the "Good to Know" document.

### Add Nginx Configuration File
Create a directory named "user_conf.d" under your project root directory. Create a myportfolio.conf inside this folder.
![image](https://user-images.githubusercontent.com/52815609/199757085-9073c006-f4c3-499c-bd44-652829f924d7.png)

Note: Replaced lines 3 and 12 with my own duckdns domain name.

Line 1-8: Listen for HTTP traffic at port 80 and 301 redirect to HTTPS

Line 11: Listen for HTTPS traffic at port 443

Line 14-16: Reverse proxy traffic to our myportfolio container port 5000

Line 19-21: Used by jonasal/nginx-certbot to generate certifications from LetsEncrypt

## Tasks

Once you've got your portfolio downloaded and running using the instructions below, you should attempt to complete the following tasks.

For each of these tasks, you should create an [Issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/about-issues) and work on them in a new [branch](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-branches). When the task has been completed, you should open a [Pull Request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) and get another fellow in your pod to give you feedback before merging it in.

*Note: Make sure to include a link to the Issue you're working on inside of your Pull Request so your reviewer knows what you're working on!*

### GitHub Tasks
- [x] Create Issues for each task below
- [x] Work on each task in a new branch
- [x] Open a Pull Request when a task is finished to get feedback

### Portfolio Tasks
- [x] Add a photo of yourself to the website
- [x] Add an "About youself" section to the website.
- [x] Add your previous work experiences
- [x] Add your hobbies (including images)
- [x] Add your current/previous education
- [x] Add a map of all the cool locations/countries you visited

### Flask Tasks
- [x] Get your Flask app running locally on your machine using the instructions below.
- [x] Add a template for adding multiple work experiences/education/hobbies using [Jinja](https://jinja.palletsprojects.com/en/3.0.x/api/#basics)
- [x] Create a new page to display hobbies.
- [x] Add a menu bar that dynamically displays other pages in the app


## Getting Started

You need to do all your work here.

## Installation

Make sure you have python3 and pip installed

This bash script I wrote allows you to deploy the portfolio site with ease. All you need to do is run the commands below, which make the redeploy-site.sh file executible and then executes the file:
```bash
$ chmod +x redeploy-site.sh
$ ./redeploy-site.sh
```
That's it?! Ya that's it thanks to bash!!

Side Note: You can use the redeploy-site.sh bash script after making a cahnge to your portfolio site to redeploy with the changes you made.
```bash
$ ./redeploy-site.sh
```

## The script you ran above did everything you would normally have to do below to install and run the site... now you don't have to! Below is just for reference.

Create and activate virtual environment using virtualenv
```bash
$ python -m venv python3-virtualenv
$ source python3-virtualenv/bin/activate
```

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install all dependencies!

```bash
pip install -r requirements.txt
```

## Usage

Create a .env file using the example.env template (make a copy using the variables inside of the template)

Start flask development server
```bash
$ export FLASK_ENV=development
$ flask run
```

You should get a response like this in the terminal:
```
❯ flask run
 * Environment: development
 * Debug mode: on
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```

You'll now be able to access the website at `localhost:5000` or `127.0.0.1:5000` in the browser! 

*Note: The portfolio site will only work on your local machine while you have it running inside of your terminal. We'll go through how to host it in the cloud in the next few weeks!* 

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
