# Papyrus

This is a rails app I built to manage content on my personal website. Feel free to fork for your own use.

Shoutout to the contributors of [Redcarpet](https://github.com/vmg/redcarpet) and [Rouge](https://github.com/jneen/rouge) for making pure ruby markdown parsing and code highlighting possible!

Next actions:
    * Refactor card controller methods
        - add tests for `review` action
        - refactor repetition module
            - isolate its actions to purely calculation
        - add tests for review_performance method. namely, always return self so we can save. or maybe we should jsut handle the save
        - move repeat? login into controller. the logic around repeated reviews should be in controller. the controller decides whether to show it again or not.
        - make card index page prettier ... 
        - add a decorator for the card index page to handle things like showing today, tomorrow, or a nicely formatted date in form "Month, day, year"
        - look into way to measure our performance over time. 
            - how many cards did I review this week?
            - which cards did I increase my score on overtime?
  
Then, we start using it in production to learn!

