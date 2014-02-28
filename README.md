# Support Map

This is a rails app to map supporters in a state/district. The app is heavily integrated with Facebook, which enables the ability to
1. have users share their support of a candidate or issue directly to Facebook
2. have users encourage their friends to support the candidate or issue
3. save the user's Facebook connections that are within the area/district. This allows [the information to be used for targeting near election day](http://swampland.time.com/2012/11/20/friended-how-the-obama-campaign-connected-with-young-voters/), for example with a follow-up email asking them to reach out to specific friends.

### Customization

Create a `application.yml` file and customize the variables that will be used in the app.

#### Facebook

Create an app at https://developers.facebook.com/.

```yml
FACEBOOK_APP_ID: "XXXX"
FACEBOOK_SECRET: "XXXX"
```

#### Campaign info

Customize to match the campaign.

```yml
CAMPAIGN_NAME: "John Doe"
CAMPAIGN_TYPE: "state" # congress, state, senate
CAMPAIGN_CONGRESSIONAL_DISTRICT: "" # e.g. "10". Leave blank if this isn't a congressional race. Use a string instead of a number
CAMPAIGN_STATE_FULL: "Virginia"
CAMPAIGN_STATE_ABBR: "VA"
```

#### Intro

Customize to the text you want displayed when a user first visits.

```yml
INTRO_HTML: "<p>Add your name velit massa placerat tortor ut aenean cursus nec, magna eu ac.</p>"
```

#### Facebook share info

Customize what will be shown when someone shares their support on Facebook.

```yml
FB_LINK_NAME: "I just made an endorsement"
FB_LINK_URL: "http://www.example.com"
FB_LINK_CAPTION: "I'm a sample caption"
FB_LINK_DESCRIPTION: "I'm the link description"
FB_LINK_PICTURE_URL: "http://www.example.com/sampleurl.png"
```

### Admin area

To view signups, visit `/admin` where ActiveAdmin is mounted. The default login info for ActiveAdmin is `admin@example.com` and `password`.

## Running locally

```
bundle install
thin start
```

## Running on Heroku

```
git clone git@github.com:tylerpearson/support-map.git
cd support-map

heroku create myapp
git push heroku master
```

## Screenshots

![Imgur](http://i.imgur.com/TdVgyBR.png)

![Imgur](http://i.imgur.com/wkbmMyR.png)