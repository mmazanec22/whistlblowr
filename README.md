# WhistlBlowr ReadMe

## Summary

WhistlBlowr is an interface that allows users to include media uploads with submissions to a generic Wordpress form.

This project was created by Alex Stevenson, Ben Van Sickle, Joe Mazrimas, and Melanie Mazanec over 8 days in September 2016 for Project Six as part of their final project at Dev Bootcamp.  This repo contains our beta version.


![Status](https://img.shields.io/badge/Rails-ver_5.0-brightgreen.svg)
![Status](https://img.shields.io/badge/Ruby-ver_2.3.1-green.svg)
![Status](https://img.shields.io/packagist/l/doctrine/orm.svg)

----
## Features

* anonymous tip/complaint reporting from the public
* option for anonymous message follow-ups from original tipster
* attach media to complaint submissions
* assign status to submissions
* export reports into Podio workflow

----
## Installation

> Whistlblowr requires environment variables to enable connectivity to AWS, access to send email and integration with Podio. Below is a list of the ENV variables that need to be created, grouped by the function they support.  We use the gem [Figaro](https://github.com/laserlemon/figaro) to manage these.

Amazon Web Services (S3):

* S3_KEY
* S3_SECRET
* S3\_BUCKET_NAME

Used for seed data to create an initial admin user:

* INVESTIGATOR_USERNAME
* INVESTIGATOR_EMAIL
* INVESTIGATOR_PASSWORD

Config from Podio to enable access to a specific app:

* PODIO\_APP_ID
* PODIO\_APP_TOKEN
* PODIO\_CLIENT_ID
* PODIO\_CLIENT_SECRET

Email username and password. These were set up to use a gmail account, but could be set up for another provider with SMTP:

* GMAIL_USERNAME
* GMAIL_PASSWORD

----
## Usage

[Devise](https://github.com/plataformatec/devise) gem for administrator management
> (Further info for developers?)

Upload limits
>


## Usage

* Devise gem for administrator management

