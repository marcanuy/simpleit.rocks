---
description: How to create objects from a one-to-many relationship with Factoryboy.
---

## Overview

[Factoryboy] is used to replace fixtures with factories for complex
objects. It already comes with solutions to handle
[one-to-one](http://factoryboy.readthedocs.io/en/latest/recipes.html#dependent-objects-foreignkey)
and
[many-to-many](http://factoryboy.readthedocs.io/en/latest/recipes.html#simple-many-to-many-relationship)
relationships, but it lacks documentation for setting up
**one-to-many** relationships, which is what we will see in this
guide.

There are two simple strategies for setting up this kind of
relationship:

1. Using Factoryboy's post generation hooks
2. Create the relationship objects "manually"

### Just Show me the code

You can check this guide full source code at <https://github.com/marcanuy/factoryboy_examples> repo.

## Setting up the example

The following examples will be based in Django models with the
following relationship (in `myapp/models.py`):

~~~ python
from django.db import models

class Player(models.Model):
    """
    Model representing a player of a team
    """
    team = models.ForeignKey(
        'team', # class name
        on_delete=models.CASCADE,
        related_name='players'
    )
    first_name = models.CharField(max_length=200, help_text="Player's first name")
    last_name = models.CharField(max_length=200, help_text="Player's last name")

class Team(models.Model, LineMixin):
    """ 
    Model representing a text Team.
    """
    name = models.CharField(max_length=200, help_text="Team name")
~~~

Having the above Django models we create a factory for each model, in
`myapp/factories.py`.

The Player's factory is straightforward, having its `team`'s related
field set up with
[factory.SubFactory](https://factoryboy.readthedocs.io/en/latest/reference.html#factory.SubFactory),
which calls the related factory, in this case: `team =
factory.SubFactory(TeamFactory)`.

~~~ python
import factory
from . import models

class PlayerFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Player

    team = factory.SubFactory(TeamFactory)
    first_name = factory.Faker('first_name')
    last_name = factory.Faker('last_name')
~~~

> class factory.SubFactory(factory, **kwargs) 
> This attribute declaration calls another Factory subclass, selecting the same build
> strategy and collecting extra kwargs in the process.  The SubFactory
> attribute should be called with: 
>  - A Factory subclass as first argument, or the fully 
>    qualified import path to that Factory
>  - An optional set of keyword arguments that should
>    be passed when calling that factory
> <footer class="blockquote-footer"> <cite><a href="https://factoryboy.readthedocs.io/en/latest/reference.html#factory.SubFactory">SubFactory docs</a></cite></footer>
{: class="blockquote" cite="https://factoryboy.readthedocs.io/en/latest/reference.html#factory.SubFactory"}

## Strategies

Now we can define the `Team` factory in one of two ways.

### Using post generation hook

To performs actions once the model object has been generated we use
the `factory.PostGeneration` hook.

In this case we will create a random amount of *Player* instances for
one *Team*, or a specific amount of *Player*'s if passed an argument.

To set up the post generation hook we use the
`@factory.post_generation` decorator and define a function whose name
will be used when calling the factory, like this

	@factory.post_generation
	def players(line, create, extracted, **kwargs):
	    pass

Now we can call it like: <kbd>TeamFactory(players=4)</kbd> it generates a
*Team* with 4 players.

If we call it without `players` it generates a random amount of *Player*'s.

In `models/factories.py`:

~~~ python
class TeamFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Team

    name = factory.Faker('sentence', nb_words=3, variable_nb_words=True)

class TeamWithPlayersFactory(TeamFactory):
    
    @factory.post_generation
    def units(obj, create, extracted, **kwargs):
        """
        If called like: TeamFactory(players=4) it generates a Team with 4
        players.  If called without `players` argument, it generates a
        random amount of players for this team
        """
        if not create:
            # Build, not create related
            return

        if extracted:
            for n in range(extracted):
                myapp.factories.PlayerFactory(team=obj)
        else:
            import random
            number_of_units = random.randint(1, 10)
            for n in range(number_of_units):
                myapp.factories.PlayerFactory(team=obj)
~~~

Then we can create some tests to show how it works (in `myapp/tests.py`):

~~~ python 
from django.test import TestCase

from myapp.factories import TeamFactory, PlayerFactory, TeamWithPlayersFactory
from myapp.models import Team, Player

class FactoriesTests(TestCase):

    def test_create_team_with_players(self):
        team = TeamWithPlayersFactory.create()
        
        self.assertIsInstance(team, Team)
        players = team.players.all()
        self.assertTrue(len(players) > 0)
        for player in players:
            self.assertIsInstance(player, Player)
~~~

### Manually creating objects

Without using the post generation hook, we can still create them
making sure we create a team before starting to create the players,
so we assign the same *Team* to all players, like:

~~~ python
team = TeamFactory.create()
player1 = PlayerFactory.create(team=team)
player2 = PlayerFactory.create(team=team)
~~~

An example with `shell`:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>python manage.py shell</kbd>
Python 3.6.4 (default, Feb  5 2018, 16:52:44) 
[GCC 7.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
<span class="shell-prompt"> >>> </span> <kbd>from myapp.factories import TeamFactory</kbd>
<span class="shell-prompt"> >>> </span> <kbd>from myapp.factories import PlayerFactory</kbd>
<span class="shell-prompt"> >>> </span> <kbd>team = TeamFactory.create()</kbd>
<span class="shell-prompt"> >>> </span> <kbd>from myapp.models import Team, Player</kbd>
<QuerySet [<Team: Room foot.>]>
<span class="shell-prompt"> >>> </span> <kbd>PlayerFactory.create(team=team)</kbd>
<Player: Amber Marshall>
<span class="shell-prompt"> >>> </span> <kbd>PlayerFactory.create(team=team)</kbd>
<Player: Cynthia Howard>
<span class="shell-prompt"> >>> </span> <kbd>team.players.all()</kbd>
<QuerySet [<Player: Amber Marshall>, <Player: Cynthia Howard>]>
<span class="shell-prompt"> >>> </span> <kbd></kbd>
</samp>
</pre>

In `myapp/tests.py`:

~~~ python
...
    def test_create_players_with_same_team(self):
        team = TeamFactory.create()
        player1 = PlayerFactory.create(team=team)
        player2 = PlayerFactory.create(team=team)

        self.assertIsInstance(player1, Player)
        self.assertIsInstance(player2, Player)
        self.assertEqual(player1.team, team)
        self.assertEqual(player2.team, team)
~~~

## Conclusion

Using the post generation hooks, is a bit harder to set up but makes
it easier to use the factory in your code.

*[Factoryboy]: http://factoryboy.readthedocs.io/en/latest/
