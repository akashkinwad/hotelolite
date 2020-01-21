$(document).on('click','.section-click', function(){
  $("li").removeClass('kt-menu__item--active');
  $(this).closest('li').addClass('kt-menu__item--active');
});

function updateSidebarActiveLinkOnScroll(event){
  var scrollPos = $(document).scrollTop();
  $('.kt-menu__nav a').each(function () {
    var currLink = $(this);
    if ($(currLink.attr("href"))[0]) {
      var refElement = $(currLink.attr("href"));
      if ((refElement.position().top - 60)  <= scrollPos && (refElement.position().top - 60) + refElement.height() > scrollPos) {
        $('.add-scroll-effect-docs ul li a').removeClass("kt-menu__item--active");
        $('.parent-sub-menu-element').removeClass("kt-menu__item--open");
        currLink.closest('li').addClass("kt-menu__item--active");
        currLink.closest('.parent-sub-menu-element').addClass('kt-menu__item--open');
      }
      else {
        currLink.closest('li').removeClass("kt-menu__item--active");
      }
    }
  });
}

$( document ).ready(function() {
  $(document).on("scroll", updateSidebarActiveLinkOnScroll);
  // Scroll to the section on click.
  $(".add-scroll-effect-docs").click(function(e) {
    var section = $(this).attr("href");
    if ($(window).width() <= 1024){
      scroll_correction_offset = 50;
    }
    else {
      scroll_correction_offset = 0;
    }
    $("html, body").animate({
      scrollTop: $(section).offset().top - scroll_correction_offset
    });
  });

  if (!library)
  var library = {};

  library.json = {
    replacer: function(match, pIndent, pKey, pVal, pEnd) {
      var key = '<span class=json-key>';
      var val = '<span class=json-value>';
      var str = '<span class=json-string>';
      var r = pIndent || '';
      if (pKey)
         r = r + key + pKey.replace(/[": ]/g, '') + '</span>: ';
      if (pVal)
         r = r + (pVal[0] == '"' ? str : val) + pVal + '</span>';
      return r + (pEnd || '');
    },
    prettyPrint: function(obj) {
      var jsonLine = /^( *)("[\w]+": )?("[^"]*"|[\w.+-]*)?([,[{])?$/mg;
      return JSON.stringify(obj, null, 3)
      .replace(/&/g, '&amp;').replace(/\\"/g, '&quot;')
      .replace(/</g, '&lt;').replace(/>/g, '&gt;')
      .replace(jsonLine, library.json.replacer);
    }
  };

  var match_index_json = {
    "data": {
      "matches": [
        {
          "match": {
            "id": 10,
            "title": "MI vs RR",
            "betfair_event_id": "",
            "play_status": "in_play",
            "team1": "mi",
            "team2": "rr",
            "sequence_string": "Demo",
            "venue": "Columbo",
            "event_type": "cricket",
            "tournament": null,
            "score": null,
            "status": "OPEN",
            "event_sub_type": "t-20",
            "start_time": "2019-02-28T00:00:00Z",
            "photo": ""
          }
        },
        {
          "match": {
            "id": 11,
            "title": "MI vs RR",
            "betfair_event_id": "",
            "play_status": "in_play",
            "team1": "mi",
            "team2": "rr",
            "sequence_string": "Demo",
            "venue": "Kanpur",
            "event_type": "cricket",
            "tournament": null,
            "score": {
              "batteamname": "mi",
              "batteamdesc": "10/0 (0.0 Ovs)",
              "batteamwkts": 0,
              "batteamovers": "20",
              "batteamruns": 0,
              "bwlteamname": "rr",
              "bwlteamdesc": "",
              "status": "",
              "event": null
            },
            "status": "OPEN",
            "event_sub_type": "t-20",
            "start_time": "2019-02-28T00:00:00Z",
            "photo": ""
          }
        },
      ]
    }
  }

  var match_show_json = {
    "data": {
      "match": {
        "id": 57,
        "title": "Shrilanka Vs SouthAfrica",
        "betfair_event_id": "",
        "play_status": "in_play",
        "team1": "Shri Lanka",
        "team2": "South Africa",
        "sequence_string": "",
        "venue": "",
        "score": {
          "batteamname": "South Africa",
          "bwlteamname": "Shri Lanka",
          "batteamovers": "3.0",
          "batteamdesc": "53/0 (3.0 Ovs)",
          "bwlteamdesc": "",
          "batteamruns": 53,
          "batteamwkts": 0,
          "status": null,
          "event": "2",
          "current_innings": "1",
          "team_1_id": 10,
          "team_2_id": 7,
          "over": 3,
          "ball": 0,
          "extras": 24,
          "striker_id": 7,
          "nonstriker_id": 6,
          "bowler_id": 4,
          "bat_team_id": 7,
          "bowl_team_id": 10
        },
        "heroic_commentary": {
          "id": 859,
          "event": "2"
        },
        "tournament": null,
        "start_time": "2019-06-28T14:27:00Z",
        "event_type": "cricket",
        "event_sub_type": "one-day"
      },
      "markets": [
        {
          "market": {
            "id": 286,
            "betfair_market_id": "Match Winner_57",
            "betfair_market_type": "Match Winner",
            "status": "SUSPEND",
            "heroic_market_type": "match_winner",
            "extra_info": null,
            "runners": [
              {
                "runner": {
                  "id": 1108,
                  "betfair_selection_id": "Shri Lanka_57",
                  "betfair_runner_name": "Shri Lanka",
                  "status": "ACTIVE",
                  "can_back": true,
                  "can_lay": true,
                  "back": 1.1,
                  "lay": 1.11,
                  "sid": "Shri Lanka_57",
                  "b": 1.1,
                  "l": 1.11
                }
              },
              {
                "runner": {
                  "id": 1109,
                  "betfair_selection_id": "South Africa_57",
                  "betfair_runner_name": "South Africa",
                  "status": "ACTIVE",
                  "can_back": true,
                  "can_lay": true,
                  "back": 1.2,
                  "lay": 1.21,
                  "sid": "South Africa_57",
                  "b": 1.2,
                  "l": 1.21
                }
              }
            ]
          }
        },
        {
          "market": {
            "id": 287,
            "betfair_market_id": "5_57_even_odd",
            "betfair_market_type": "Shrilanka 5 Over Last Digit Even Odd",
            "status": "SUSPEND",
            "heroic_market_type": "even_odd",
            "extra_info": {
              "team_name": "Shrilanka",
              "over": "5"
            },
            "runners": [
              {
                "runner": {
                  "id": 1110,
                  "betfair_selection_id": "287_even",
                  "betfair_runner_name": "Even",
                  "status": "ACTIVE",
                  "can_back": true,
                  "can_lay": false,
                  "back": 1.95,
                  "lay": 1.01,
                  "sid": "287_even",
                  "b": 1.95,
                  "l": 1.01
                }
              },
              {
                "runner": {
                  "id": 1111,
                  "betfair_selection_id": "287_odd",
                  "betfair_runner_name": "Odd",
                  "status": "ACTIVE",
                  "can_back": true,
                  "can_lay": false,
                  "back": 1.95,
                  "lay": 1.01,
                  "sid": "287_odd",
                  "b": 1.95,
                  "l": 1.01
                }
              }
            ]
          }
        },
        {
          "market": {
            "id": 288,
            "betfair_market_id": "5_57_ending_digit",
            "betfair_market_type": "Shrilanka 5 Over Ending Digit",
            "status": "SUSPEND",
            "heroic_market_type": "ending_digit",
            "extra_info": {
              "team_name": "Shrilanka",
              "over": "5"
            },
            "runners": [
              {
                "runner": {
                  "id": 1112,
                  "betfair_selection_id": "288_ending_digit_0",
                  "betfair_runner_name": "0",
                  "status": "ACTIVE",
                  "can_back": true,
                  "can_lay": false,
                  "back": 9.5,
                  "lay": 0.01,
                  "sid": "288_ending_digit_0",
                  "b": 9.5,
                  "l": 0.01
                }
              },
              {
                "runner": {
                  "id": 1113,
                  "betfair_selection_id": "288_ending_digit_1",
                  "betfair_runner_name": "1",
                  "status": "ACTIVE",
                  "can_back": false,
                  "can_lay": false,
                  "back": 9.5,
                  "lay": null,
                  "sid": "288_ending_digit_1",
                  "b": 9.5,
                  "l": null
                }
              },
              {
                "runner": {
                  "id": 1114,
                  "betfair_selection_id": "288_ending_digit_2",
                  "betfair_runner_name": "2",
                  "status": "ACTIVE",
                  "can_back": false,
                  "can_lay": false,
                  "back": 9.5,
                  "lay": null,
                  "sid": "288_ending_digit_2",
                  "b": 9.5,
                  "l": null
                }
              },
              {
                "runner": {
                  "id": 1115,
                  "betfair_selection_id": "288_ending_digit_3",
                  "betfair_runner_name": "3",
                  "status": "ACTIVE",
                  "can_back": false,
                  "can_lay": false,
                  "back": 9.5,
                  "lay": null,
                  "sid": "288_ending_digit_3",
                  "b": 9.5,
                  "l": null
                }
              },
              {
                "runner": {
                  "id": 1116,
                  "betfair_selection_id": "288_ending_digit_4",
                  "betfair_runner_name": "4",
                  "status": "ACTIVE",
                  "can_back": false,
                  "can_lay": false,
                  "back": 9.5,
                  "lay": null,
                  "sid": "288_ending_digit_4",
                  "b": 9.5,
                  "l": null
                }
              },
              {
                "runner": {
                  "id": 1117,
                  "betfair_selection_id": "288_ending_digit_5",
                  "betfair_runner_name": "5",
                  "status": "ACTIVE",
                  "can_back": false,
                  "can_lay": false,
                  "back": 9.5,
                  "lay": null,
                  "sid": "288_ending_digit_5",
                  "b": 9.5,
                  "l": null
                }
              },
              {
                "runner": {
                  "id": 1118,
                  "betfair_selection_id": "288_ending_digit_6",
                  "betfair_runner_name": "6",
                  "status": "ACTIVE",
                  "can_back": false,
                  "can_lay": false,
                  "back": 9.5,
                  "lay": null,
                  "sid": "288_ending_digit_6",
                  "b": 9.5,
                  "l": null
                }
              },
              {
                "runner": {
                  "id": 1119,
                  "betfair_selection_id": "288_ending_digit_7",
                  "betfair_runner_name": "7",
                  "status": "ACTIVE",
                  "can_back": false,
                  "can_lay": false,
                  "back": 9.5,
                  "lay": null,
                  "sid": "288_ending_digit_7",
                  "b": 9.5,
                  "l": null
                }
              },
              {
                "runner": {
                  "id": 1120,
                  "betfair_selection_id": "288_ending_digit_8",
                  "betfair_runner_name": "8",
                  "status": "ACTIVE",
                  "can_back": false,
                  "can_lay": false,
                  "back": 9.5,
                  "lay": null,
                  "sid": "288_ending_digit_8",
                  "b": 9.5,
                  "l": null
                }
              },
              {
                "runner": {
                  "id": 1121,
                  "betfair_selection_id": "288_ending_digit_9",
                  "betfair_runner_name": "9",
                  "status": "ACTIVE",
                  "can_back": false,
                  "can_lay": false,
                  "back": 9.5,
                  "lay": null,
                  "sid": "288_ending_digit_9",
                  "b": 9.5,
                  "l": null
                }
              }
            ]
          }
        }
      ],
      "sessions": [
        {
          "session": {
            "id": 246,
            "match_id": 57,
            "innings": 1,
            "overs": 15,
            "can_yes": true,
            "can_no": true,
            "title": "15 Overs",
            "status": "SUSPEND",
            "team": "Shrilanka",
            "session_run": {
              "id": 235,
              "session_id": 246,
              "no_run": 20,
              "yes_run": 21,
              "no_rate": 2.0,
              "yes_rate": 2.0
            }
          }
        },
        {
          "session": {
            "id": 245,
            "match_id": 57,
            "innings": 1,
            "overs": 10,
            "can_yes": true,
            "can_no": true,
            "title": "10 Overs",
            "status": "SUSPEND",
            "team": "Shrilanka",
            "session_run": {
              "id": 231,
              "session_id": 245,
              "no_run": 11,
              "yes_run": 12,
              "no_rate": 2.0,
              "yes_rate": 2.0
            }
          }
        },
        {
          "session": {
            "id": 244,
            "match_id": 57,
            "innings": 1,
            "overs": 6,
            "can_yes": true,
            "can_no": true,
            "title": "6 Overs",
            "status": "SUSPEND",
            "team": "Shrilanka",
            "session_run": {
              "id": 232,
              "session_id": 244,
              "no_run": 3,
              "yes_run": 4,
              "no_rate": 2.0,
              "yes_rate": 2.0
            }
          }
        }
      ]
    }
  }

  $('#match_index_json').html(library.json.prettyPrint(match_index_json));
  $('#match_show_json').html(library.json.prettyPrint(match_show_json));
});
