import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:dissipate/podo/hero_item.dart';
import 'package:dissipate/util/const.dart';
import 'package:dissipate/widget/superhero_avatar.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.heroItem});

  final HeroItem heroItem;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.appName),
      ),
      body: SuperheroDetails(widget: widget, heroItem: widget.heroItem),
    );
  }
}

class SuperheroDetails extends StatefulWidget {
  const SuperheroDetails({
    super.key,
    required this.widget,
    required this.heroItem,
  });

  final Details widget;
  final HeroItem heroItem;

  @override
  State<SuperheroDetails> createState() => _SuperheroDetailsState();
}

class _SuperheroDetailsState extends State<SuperheroDetails> {
  final Map<String, bool> _categoryExpansionStateMap = {
    "Biography": true,
    "Appearance": false,
    "Work": false,
    "Power Stats": false,
    "Connections": false,
  };
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.heroItem.id,
              child: SuperheroAvatar(
                img: widget.heroItem.images.md,
                radius: 50.0,
              ),
            ),
            const SizedBox(
              height: 13.0,
            ),
            Text(
              widget.heroItem.name,
              style: textTheme.titleLarge,
            ),
            Text(
              widget.heroItem.biography.fullName.isEmpty
                  ? widget.heroItem.name
                  : widget.heroItem.biography.fullName,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _categoryExpansionStateMap[_categoryExpansionStateMap.keys
                      .toList()[index]] = !isExpanded;
                });
              },
              children: <ExpansionPanel>[
                ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                          title: Text(
                        "Biography",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ));
                    },
                    body: Biography(
                      heroItem: widget.heroItem,
                    ),
                    isExpanded:
                        _categoryExpansionStateMap["Biography"] != null),
                ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                          title: Text(
                        "Appearance",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ));
                    },
                    body: Appearance(
                      heroItem: widget.heroItem,
                    ),
                    isExpanded:
                        _categoryExpansionStateMap["Appearance"] != null),
                ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                          title: Text(
                        "Work",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ));
                    },
                    body: Work(
                      heroItem: widget.heroItem,
                    ),
                    isExpanded: _categoryExpansionStateMap["Work"] != null),
                ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                          title: Text(
                        "Power Stats",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ));
                    },
                    body: PowerStats(
                      heroItem: widget.heroItem,
                    ),
                    isExpanded:
                        _categoryExpansionStateMap["Power Stats"] != null),
                ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                          title: Text(
                        "Connections",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ));
                    },
                    body: Connections(
                      heroItem: widget.heroItem,
                    ),
                    isExpanded:
                        _categoryExpansionStateMap["Connections"] != null),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Biography extends StatelessWidget {
  const Biography({super.key, required this.heroItem});

  final HeroItem heroItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "Alter Ego(s)".toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: Text(
            heroItem.biography.alterEgos,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ListTile(
          title: Text(
            "Aliases".toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: Text(
            heroItem.biography.aliases
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        ListTile(
          title: Text(
            "Place of birth".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            heroItem.biography.placeOfBirth,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        ListTile(
          title: Text(
            "First Appearance".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            heroItem.biography.firstAppearance,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        ListTile(
          title: Text(
            "Creator".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            heroItem.biography.publisher,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}

class Appearance extends StatelessWidget {
  const Appearance({super.key, required this.heroItem});

  final HeroItem heroItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "Gender".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            heroItem.appearance.gender,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        ListTile(
          title: Text(
            "Race".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            heroItem.appearance.race
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        ListTile(
          title: Text(
            "Height".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            heroItem.appearance.height
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        ListTile(
          title: Text(
            "Weight".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            heroItem.appearance.weight
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        ListTile(
          title: Text(
            "Eye Color".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            heroItem.appearance.eyeColor,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}

class Work extends StatelessWidget {
  const Work({super.key, required this.heroItem});

  final HeroItem heroItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Base".toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        heroItem.work.base,
        style: const TextStyle(fontWeight: FontWeight.w300),
      ),
    );
  }
}

class PowerStats extends StatelessWidget {
  final HeroItem heroItem;

  const PowerStats({super.key, required this.heroItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "${"Intelligence".toUpperCase()} - ${heroItem.powerstats.intelligence}%",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: LinearPercentIndicator(
            animation: true,
            lineHeight: 15.0,
            animationDuration: 5000,
            percent: heroItem.powerstats.intelligence.toDouble() / 100.0,
            barRadius: const Radius.circular(16),
            progressColor: Colors.blue,
          ),
        ),
        ListTile(
          title: Text(
            "${"Strength".toUpperCase()} - ${heroItem.powerstats.strength}%",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: LinearPercentIndicator(
            animation: true,
            lineHeight: 15.0,
            animationDuration: 5000,
            percent: heroItem.powerstats.strength.toDouble() / 100.0,
            barRadius: const Radius.circular(16),
            progressColor: Colors.orange,
          ),
        ),
        ListTile(
          title: Text(
            "${"Speed".toUpperCase()} - ${heroItem.powerstats.speed}%",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: LinearPercentIndicator(
            animation: true,
            lineHeight: 15.0,
            animationDuration: 5000,
            percent: heroItem.powerstats.speed.toDouble() / 100.0,
            barRadius: const Radius.circular(16),
            progressColor: Colors.green,
          ),
        ),
        ListTile(
          title: Text(
            "${"Durability".toUpperCase()} - ${heroItem.powerstats.durability}%",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: LinearPercentIndicator(
            animation: true,
            lineHeight: 15.0,
            animationDuration: 5000,
            percent: heroItem.powerstats.durability.toDouble() / 100.0,
            barRadius: const Radius.circular(16),
            progressColor: Colors.orangeAccent,
          ),
        ),
        ListTile(
          title: Text(
            "${"Power".toUpperCase()} - ${heroItem.powerstats.power}%",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: LinearPercentIndicator(
            animation: true,
            lineHeight: 15.0,
            animationDuration: 5000,
            percent: heroItem.powerstats.power.toDouble() / 100.0,
            barRadius: const Radius.circular(16),
            progressColor: Colors.red,
          ),
        ),
        ListTile(
          title: Text(
            "${"Combat".toUpperCase()} - ${heroItem.powerstats.combat}%",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: LinearPercentIndicator(
            animation: true,
            lineHeight: 15.0,
            animationDuration: 5000,
            percent: heroItem.powerstats.combat.toDouble() / 100.0,
            barRadius: const Radius.circular(16),
            progressColor: Colors.black,
          ),
        ),
      ],
    );
  }
}

class Connections extends StatelessWidget {
  final HeroItem heroItem;

  const Connections({super.key, required this.heroItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "Team Affiliation".toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: Text(
            heroItem.connections.groupAffiliation,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ListTile(
          title: Text(
            "Relatives".toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: Text(
            heroItem.connections.relatives
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
