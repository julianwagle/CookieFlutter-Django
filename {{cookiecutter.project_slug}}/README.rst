CookieFlutter Django 🍪✂️ 🚀🦄 🎯
==============================

.. image:: https://img.shields.io/github/workflow/status/pydanny/cookiecutter-django/CI/master
    :target: https://github.com/pydanny/cookiecutter-django/actions?query=workflow%3ACI
    :alt: Build Status

.. image:: https://www.codetriage.com/pydanny/cookiecutter-django/badges/users.svg
    :target: https://www.codetriage.com/pydanny/cookiecutter-django
    :alt: Code Helpers Badge

.. image:: https://img.shields.io/badge/code%20style-black-000000.svg
    :target: https://github.com/ambv/black
    :alt: Code style: black


Overview
---------
CookieFlutter Django is a spin off of Cookiecutter Django. 
It is customized for my workflow and includes tools for handling GIS data, web-scraping, data analyisis, task managament, cron jobs, and a Flutter frontend.


Usage (Backend)
---------------

First, get Cookiecutter. Trust me, it's awesome::

    $ pip install "cookiecutter>=1.7.0"

Now run it against this repo::

    $ cookiecutter https://github.com/julianwagle/cookieflutter-django

You'll be prompted for some values. Provide them, then a project will be created for you.

Finally, move to the root directory and enter the following::

    $ docker-compose -f local.yml up --build
    
For a list of DRF endpoints you can view the docs here: https://dj-rest-auth.readthedocs.io/en/latest/api_endpoints.html


Usage (Frontend)
----------------

If you want to fire up the Flutter frontend, you'll have to first, have isntalled all the necessary packages and configured your local machine. 

For more on that you can follow these docs: https://flutter.dev/docs/get-started/install

Once you've got your machine set up you can run the following in the frontend dir::

        $ cd frontend; flutter channel master; flutter upgrade; flutter pub get; flutter run


Troubleshooting
---------------

IF you opt in to both Celery AND PostGIS, the first time you start this up, celerybeat may not properly insert a colomn into the database. However, the second time it will all work fine.


Todo List
---------

I've still got to finish integrating the frontend with the authentication on the back end. 

Finally, I'll adjust the production settings accordingly to allow for seamless push to production.


