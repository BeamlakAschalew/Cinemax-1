// ignore_for_file: avoid_unnecessary_containers

import 'package:cinemax/screens/crew_detail.dart';

import '/api/endpoints.dart';
import '/constants/api_constants.dart';
import '/constants/style_constants.dart';
import '/modals/tv.dart';
import '/screens/guest_star_detail.dart';
import '/screens/tv_stream_select.dart';
import '/screens/tv_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:readmore/readmore.dart';
import 'movie_widgets.dart';

class EpisodeDetailPage extends StatefulWidget {
  final EpisodeList episodeList;
  final List<EpisodeList>? episodes;
  final int? tvId;
  final String? seriesName;

  const EpisodeDetailPage({
    Key? key,
    required this.episodeList,
    this.episodes,
    this.tvId,
    this.seriesName,
  }) : super(key: key);

  @override
  _EpisodeDetailPageState createState() => _EpisodeDetailPageState();
}

class _EpisodeDetailPageState extends State<EpisodeDetailPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<EpisodeDetailPage> {
  late TabController tabController;
  late Mixpanel mixpanel;
  @override
  void initState() {
    super.initState();
    initMixpanel();
    tabController = TabController(length: 4, vsync: this);
  }

  Future<void> initMixpanel() async {
    mixpanel = await Mixpanel.init("c46981e69e00f916418c0dfd0d27f1be",
        optOutTrackingDefault: false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    widget.episodeList.stillPath == null
                        ? Image.asset(
                            'assets/images/na_logo.png',
                            fit: BoxFit.cover,
                          )
                        : FadeInImage(
                            width: double.infinity,
                            height: double.infinity,
                            image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                'original/' +
                                widget.episodeList.stillPath!),
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage('assets/images/loading_5.gif'),
                          ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                const Color(0xFFF57C00),
                                const Color(0xFFF57C00).withOpacity(0.3),
                                const Color(0xFFF57C00).withOpacity(0.2),
                                const Color(0xFFF57C00).withOpacity(0.1),
                              ],
                              stops: const [
                                0.0,
                                0.25,
                                0.5,
                                0.75
                              ])),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFF57C00),
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.black38),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFF57C00),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                actions: const [
                  TopButton(
                    buttonText: 'Open season',
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 75, 16, 16),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: const Color(0xFF2b2c30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 8.0, 8.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${widget.episodeList.seasonNumber! <= 9 ? 'S0${widget.episodeList.seasonNumber}' : 'S${widget.episodeList.seasonNumber}'} | '
                                                '${widget.episodeList.episodeNumber! <= 9 ? 'E0${widget.episodeList.episodeNumber}' : 'E${widget.episodeList.episodeNumber}'}'
                                                '',
                                                style: kTextSmallHeaderStyle,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.episodeList.name
                                                          .toString(),
                                                      maxLines: 2,
                                                      style:
                                                          kTextSmallHeaderStyle,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0),
                                                      child: Text(
                                                        widget.seriesName!,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white38),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      child: Image.asset(
                                                          'assets/images/tmdb_logo.png'),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          3.0),
                                                              child: Icon(
                                                                Icons.star,
                                                                size: 15,
                                                                color: Color(
                                                                    0xFFF57C00),
                                                              ),
                                                            ),
                                                            Text(
                                                              widget.episodeList
                                                                  .voteAverage!
                                                                  .toStringAsFixed(
                                                                      1),
                                                              // style: widget.themeData
                                                              //     .textTheme.bodyText1,
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Row(
                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .people_alt,
                                                                    size: 15),
                                                              ),
                                                              Text(
                                                                widget
                                                                    .episodeList
                                                                    .voteCount!
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            10),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TabBar(
                                    isScrollable: true,
                                    indicatorColor: const Color(0xFFF57C00),
                                    indicatorWeight: 3,
                                    unselectedLabelColor: Colors.white54,
                                    labelColor: Colors.white,
                                    tabs: const [
                                      Tab(
                                        child: Text('About',
                                            style: TextStyle(
                                                fontFamily: 'Poppins')),
                                      ),
                                      Tab(
                                        child: Text('Cast',
                                            style: TextStyle(
                                                fontFamily: 'Poppins')),
                                      ),
                                      Tab(
                                        child: Text('Crew',
                                            style: TextStyle(
                                                fontFamily: 'Poppins')),
                                      ),
                                      Tab(
                                        child: Text('Guest Stars',
                                            style: TextStyle(
                                                fontFamily: 'Poppins')),
                                      ),
                                    ],
                                    controller: tabController,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      Container(
                                        color: const Color(0xFF202124),
                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: const <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Text(
                                                      'Overview',
                                                      style: kTextHeaderStyle,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ReadMoreText(
                                                  widget.episodeList.overview!
                                                          .isEmpty
                                                      ? 'This season doesn\'t have an overview'
                                                      : widget.episodeList
                                                          .overview!,
                                                  trimLines: 4,
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins'),
                                                  colorClickableText:
                                                      const Color(0xFFF57C00),
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText:
                                                      'read more',
                                                  trimExpandedText: 'read less',
                                                  lessStyle: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFFF57C00),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  moreStyle: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFFF57C00),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            bottom: 4.0),
                                                    child: Text(
                                                      widget
                                                                  .episodeList
                                                                  .airDate!
                                                                  .isEmpty ||
                                                              widget.episodeList
                                                                      .airDate ==
                                                                  null
                                                          ? 'Episode air date: N/A'
                                                          : 'Episode air date:  ${DateTime.parse(widget.episodeList.airDate!).day} ${DateFormat("MMMM").format(DateTime.parse(widget.episodeList.airDate!))}, ${DateTime.parse(widget.episodeList.airDate!).year}',
                                                      style: const TextStyle(
                                                        fontFamily: 'PoppinsSB',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                      maximumSize:
                                                          MaterialStateProperty
                                                              .all(const Size(
                                                                  150, 50)),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(const Color(
                                                                  0xFFF57C00))),
                                                  onPressed: () {
                                                    mixpanel.track(
                                                        'Most viewed TV series',
                                                        properties: {
                                                          'TV series name':
                                                              '${widget.seriesName}',
                                                          'TV series id':
                                                              '${widget.tvId}',
                                                          'TV series episode name':
                                                              '${widget.episodeList.name}',
                                                          'TV series season number':
                                                              '${widget.episodeList.seasonNumber}',
                                                          'TV series episode number':
                                                              '${widget.episodeList.episodeNumber}'
                                                        });
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return TVStreamSelect(
                                                        episodeName: widget
                                                            .episodeList.name!,
                                                        tvSeriesName:
                                                            widget.seriesName!,
                                                        tvSeriesId:
                                                            widget.tvId!,
                                                        episodeNumber: widget
                                                            .episodeList
                                                            .episodeNumber!,
                                                        seasonNumber: widget
                                                            .episodeList
                                                            .seasonNumber!,
                                                      );
                                                    }));
                                                  },
                                                  child: Row(
                                                    children: const [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10),
                                                        child: Icon(
                                                          Icons.play_circle,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        'WATCH NOW',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              ScrollingTVEpisodeCasts(
                                                api:
                                                    Endpoints.getEpisodeCredits(
                                                        widget.tvId!,
                                                        widget.episodeList
                                                            .seasonNumber!,
                                                        widget.episodeList
                                                            .episodeNumber!),
                                              ),
                                              TVEpisodeImagesDisplay(
                                                title: 'Images',
                                                api: Endpoints
                                                    .getTVEpisodeImagesUrl(
                                                        widget.tvId!,
                                                        widget.episodeList
                                                            .seasonNumber!,
                                                        widget.episodeList
                                                            .episodeNumber!),
                                              ),
                                              TVVideosDisplay(
                                                api: Endpoints
                                                    .getTVEpisodeVideosUrl(
                                                        widget.tvId!,
                                                        widget.episodeList
                                                            .seasonNumber!,
                                                        widget.episodeList
                                                            .episodeNumber!),
                                                title: 'Videos',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TVEpisodeCastTab(
                                          api: Endpoints.getEpisodeCredits(
                                              widget.tvId!,
                                              widget.episodeList.seasonNumber!,
                                              widget
                                                  .episodeList.episodeNumber!)),
                                      TVCrewTab(
                                          api: Endpoints.getEpisodeCredits(
                                              widget.tvId!,
                                              widget.episodeList.seasonNumber!,
                                              widget
                                                  .episodeList.episodeNumber!)),
                                      TVEpisodeGuestStarsTab(
                                          api: Endpoints.getEpisodeCredits(
                                              widget.tvId!,
                                              widget.episodeList.seasonNumber!,
                                              widget
                                                  .episodeList.episodeNumber!)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
