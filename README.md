# Phone Number Formatter Trail - Exercise #3

## Getting started

```
# Navigate to the trail folder
cd phone-number-formatter-trail

# Clone this repo
git clone git@github.com:codelix-org/phone-number-exercise-3.git 
cd phone-number-exercise-3

# Install dependencies
bundle 

# create branch
git checkout -b attempt-YOURNAMEHERE

# Copy your code from exercise 2 (just lib, not spec) and commit
cp -R ../phone-number-exercise-2/lib ./
git add .
git commit -m 'add code from exercise 2'
```

## Exercise instructions

In this exercise you'll be extending our phone number formatter to handle phone numbers 
that are from a new country. The name of the country is Madeup Land with a country code of 
MUL (like how `United Kingdom` has a country code of `UK`)

### Validity rules: 
* Valid prefixes are: `+55`, `55` and `1`
* Numbers are 5 numbers long (not including prefix and not including spaces)
* Valid numbers (after the prefix) always start with an `8`

Example __valid__ numbers:
```
+5582345
55 82345
1 82 34 5
```

Example __invalid__ numbers:
```
+558234 // too short
55823456 // too long
142345 // first number after prefix is wrong
+5982345 // invalid prefix
```

### Formatting rules:

The number should always be saved with the `1` prefix. For example `+5582345` would become `182345`

You need to cover this new behaviour with automated tests and you will not pass this exercise without good test coverage.

When you've completed the task, push your branch to github and create a PR for the branch.

## Marking this exercise

This exercise will be marked manually and when it is approved by an approved reviewer a github action will send a notification to Codelix to notify you have passed the exercise.

After the PR has been approved you should see this updated fairly quickly in www.codelix.co.uk but if you don't you can check the `Actions` tab in this repo
to see if the action failed and reach out to @Robfaldo for help.
