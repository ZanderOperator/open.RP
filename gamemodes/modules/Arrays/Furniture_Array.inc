// All Colors, Textures, Furniture & Business Furniture Arrays in one place.

enum E_COLOR_DATA
{
    clName[26],
    clRGB[15], 
    clEmbedCol[15] 
}

new const ColorList[][E_COLOR_DATA] =
{
    {"Maroon",              "0xFF800000", "{800000}"}, //R
    {"Dark Red",            "0xFF8B0000", "{A52A2A}"},
    {"Brown",               "0xFFA52A2A", "{A52A2A}"},
    {"Firebrick",           "0xFFB22222", "{B22222}"},
    {"Crimson",             "0xFFDC143C", "{DC143C}"},
    {"Red",                 "0xFFFF0000", "{FF0000}"},
    {"Tomato",              "0xFFFF6347", "{FF6347}"},
    {"Coral",               "0xFFFF7F50", "{FF7F50}"},
    {"Indian red",          "0xFFCD5C5C", "{CD5C5C}"},
    {"Light coral",         "0xFFF08080", "{F08080}"},
    {"Dark salmon",         "0xFFE9967A", "{E9967A}"},
    {"Salmon",              "0xFFFA8072", "{FA8072}"},
    {"Light salmon",        "0xFFFFA07A", "{FFA07A}"},
    {"Orange red",          "0xFFFF4500", "{FF4500}"},
    {"Dark orange",         "0xFFFF8C00", "{FF8C00}"},
    {"Orange",              "0xFFFFA500", "{FFA500}"},
    {"Gold",                "0xFFFFD700", "{FFD700}"},
    {"Dark gold",           "0xFFB8860B", "{B8860B}"},
    {"Golden rod",          "0xFFDAA520", "{DAA520}"},
    {"Pale golden",         "0xFFEEE8AA", "{EEE8AA}"}, //G
    {"Dark khaki",          "0xFFBDB76B", "{BDB76B}"},
    {"Khaki",               "0xFFF0E68C", "{F0E68C}"},
    {"Olive",               "0xFF808000", "{808000}"},
    {"Yellow",              "0xFFFFFF00", "{FFFF00}"},
    {"Yellow green",        "0xFF9ACD32", "{9ACD32}"},
    {"Dark olive",          "0xFF556B2F", "{556B2F}"},
    {"Olive drab",          "0xFF6B8E23", "{6B8E23}"},
    {"Lawn green",          "0xFF7CFC00", "{7CFC00}"},
    {"Chart reuse",         "0xFF7FFF00", "{7FFF00}"},
    {"Green yellow",        "0xFFADFF2F", "{ADFF2F}"},
    {"Dark green",          "0xFF006400", "{006400}"},
    {"Green",               "0xFF008000", "{008000}"},
    {"Forest green",        "0xFF228B22", "{228B22}"},
    {"Lime",                "0xFF00FF00", "{00FF00}"},
    {"Lime green",          "0xFF32CD32", "{32CD32}"},
    {"Light green",         "0xFF90EE90", "{90EE90}"},
    {"Pale green",          "0xFF98FB98", "{98FB98}"},
    {"Dark sea green",      "0xFF8FBC8F", "{8FBC8F}"},
    {"Medium spring green", "0xFF00FA9A", "{00FA9A}"},
    {"Spring green",        "0xFF00FF7F", "{00FF7F}"},
    {"Sea green",           "0xFF2E8B57", "{2E8B57}"},
    {"Medium aqua marine",  "0xFF66CDAA", "{66CDAA}"},
    {"Medium sea green",    "0xFF3CB371", "{3CB371}"},
    {"Light sea green",     "0xFF20B2AA", "{20B2AA}"}, //B
    {"Dark slate gray",     "0xFF2F4F4F", "{2F4F4F}"},
    {"Teal",                "0xFF008080", "{008080}"},
    {"Dark cyan",           "0xFF008B8B", "{008B8B}"},
    {"Aqua",                "0xFF00FFFF", "{00FFFF}"},
    {"Cyan",                "0xFF00FFFF", "{00FFFF}"},
    {"Light cyan",          "0xFFE0FFFF", "{E0FFFF}"},
    {"Dark turquoise",      "0xFF00CED1", "{00CED1}"},
    {"Turquoise",           "0xFF40E0D0", "{40E0D0}"},
    {"Medium turquoise",    "0xFF48D1CC", "{48D1CC}"},
    {"Pale turquoise",      "0xFFAFEEEE", "{AFEEEE}"},
    {"Aqua marine",         "0xFF7FFFD4", "{7FFFD4}"},
    {"Powder blue",         "0xFFB0E0E6", "{B0E0E6}"},
    {"Cadet blue",          "0xFF5F9EA0", "{5F9EA0}"},
    {"Steel blue",          "0xFF4682B4", "{4682B4}"},
    {"Corn flower blue",    "0xFF6495ED", "{6495ED}"},
    {"Deep sky blue",       "0xFF00BFFF", "{00BFFF}"},
    {"Dodger blue",         "0xFF1E90FF", "{1E90FF}"},
    {"Light blue",          "0xFFADD8E6", "{ADD8E6}"},
    {"Light sky blue",      "0xFF87CEFA", "{87CEFA}"},
    {"Midnight blue",       "0xFF191970", "{191970}"},
    {"Navy",                "0xFF000080", "{000080}"},
    {"Dark blue",           "0xFF00008B", "{00008B}"},
    {"Medium blue",         "0xFF0000CD", "{0000CD}"},
    {"Blue",                "0xFF0000FF", "{0000FF}"},
    {"Royal blue",          "0xFF4169E1", "{4169E1}"},
    {"Blue violet",         "0xFF8A2BE2", "{8A2BE2}"},
    {"Indigo",              "0xFF4B0082", "{4B0082}"},
    {"Dark slate blue",     "0xFF483D8B", "{483D8B}"},
    {"Slate blue",          "0xFF6A5ACD", "{6A5ACD}"},
    {"Medium slate blue",   "0xFF7B68EE", "{7B68EE}"},
    {"Medium purple",       "0xFF9370DB", "{9370DB}"},
    {"Dark magneta",        "0xFF8B008B", "{8B008B}"},
    {"Dark violet",         "0xFF9400D3", "{9400D3}"},
    {"Dark orchid",         "0xFF9932CC", "{9932CC}"},
    {"Medium orchid",       "0xFFBA55D3", "{BA55D3}"},
    {"Purple",              "0xFF800080", "{800080}"},
    {"Thistle",             "0xFFD8BFD8", "{D8BFD8}"},
    {"Plum",                "0xFFDDA0DD", "{DDA0DD}"},
    {"Violet",              "0xFFEE82EE", "{EE82EE}"},
    {"Magenta",             "0xFFFF00FF", "{FF00FF}"},
    {"Orchid",              "0xFFDA70D6", "{DA70D6}"},
    {"Medium violet red",   "0xFFC71585", "{C71585}"},
    {"Pale violet red",     "0xFFDB7093", "{DB7093}"},
    {"Deep pink",           "0xFFFF1493", "{FF1493}"},
    {"Hot pink",            "0xFFFF69B4", "{FF69B4}"},
    {"Light pink",          "0xFFFFB6C1", "{FFB6C1}"},
    {"Pink",                "0xFFFFC0CB", "{FFC0CB}"},
    {"Antique white",       "0xFFFAEBD7", "{FAEBD7}"},
    {"Beige",               "0xFFF5F5DC", "{F5F5DC}"},
    {"Bisque",              "0xFFFFE4C4", "{FFE4C4}"},
    {"Blanched aimond",     "0xFFFFEBCD", "{FFEBCD}"},
    {"Wheat",               "0xFFF5DEB3", "{F5DEB3}"},
    {"Corn silk",           "0xFFFFF8DC", "{FFF8DC}"},
    {"Lemon chiffon",       "0xFFFFFACD", "{FFFACD}"},
    {"Golden rod yellow",   "0xFFFAFAD2", "{FAFAD2}"},
    {"Light yellow",        "0xFFFFFFE0", "{FFFFE0}"},
    {"Saddie brown",        "0xFF8B4513", "{8B4513}"},
    {"Sienna",              "0xFFA0522D", "{A0522D}"},
    {"Chocolate",           "0xFFD2691E", "{D2691E}"},
    {"Peru",                "0xFFCD853F", "{CD853F}"},
    {"Sandy brown",         "0xFFF4A460", "{F4A460}"},
    {"Burly wood",          "0xFFDEB887", "{DEB887}"},
    {"Tan",                 "0xFFD2B48C", "{D2B48C}"},
    {"Rosy brown",          "0xFFBC8F8F", "{BC8F8F}"},
    {"Moccasin",            "0xFFFFE4B5", "{FFE4B5}"},
    {"Navajo white",        "0xFFFFDEAD", "{FFDEAD}"},
    {"Peach puff",          "0xFFFFDAB9", "{FFDAB9}"},
    {"Misty rose",          "0xFFFFE4E1", "{FFE4E1}"},
    {"Lavender blush",      "0xFFFFF0F5", "{FFF0F5}"},
    {"Linen",               "0xFFFAF0E6", "{FAF0E6}"},
    {"Old lace",            "0xFFFDF5E6", "{FDF5E6}"},
    {"Papaya whip",         "0xFFFFEFD5", "{FFEFD5}"},
    {"Sea shell",           "0xFFFFF5EE", "{FFF5EE}"},
    {"Mint cream",          "0xFFF5FFFA", "{F5FFFA}"},
    {"Slate gray",          "0xFF708090", "{708090}"},
    {"Light slate gray",    "0xFF778899", "{778899}"},
    {"Light steel blue",    "0xFFB0C4DE", "{B0C4DE}"},
    {"Lavender",            "0xFFE6E6FA", "{E6E6FA}"},
    {"Floral white",        "0xFFFFFAF0", "{FFFAF0}"},
    {"Alice blue",          "0xFFF0F8FF", "{F0F8FF}"},
    {"Ghost white",         "0xFFF8F8FF", "{F8F8FF}"},
    {"Honeydew",            "0xFFF0FFF0", "{F0FFF0}"},
    {"Ivory",               "0xFFFFFFF0", "{FFFFF0}"},
    {"Azure",               "0xFFF0FFFF", "{F0FFFF}"},
    {"Snow",                "0xFFFFFAFA", "{FFFAFA}"},
    {"Black",               "0xFF000000", "{000000}"},
    {"Dim gray",            "0xFF696969", "{696969}"},
    {"Gray",                "0xFF808080", "{808080}"},
    {"Dark gray",           "0xFFA9A9A9", "{A9A9A9}"},
    {"Silver",              "0xFFC0C0C0", "{C0C0C0}"},
    {"Light gray",          "0xFFD3D3D3", "{D3D3D3}"},
    {"Gainsboro",           "0xFFDCDCDC", "{DCDCDC}"},
    {"White smoke",         "0xFFF5F5F5", "{F5F5F5}"},
    {"White",               "0xFFFFFFFF", ""}
};

enum E_TEXTURES_DATA
{
    tModel,
    tTXDName[32],
    tName[32]
}
new const ObjectTextures[][E_TEXTURES_DATA] =
{
    {-1,       "none",                   "none"                  },
    {10101,    "2notherbuildsfe",        "Bow_Abpave_Gen"        },
    {10101,    "2notherbuildsfe",        "ferry_build14"         },
    {10101,    "2notherbuildsfe",        "sl_vicbrikwall01"      },
    {10101,    "2notherbuildsfe",        "sl_vicwall01"          },
    {10101,    "2notherbuildsfe",        "ws_rooftarmac1"        },
    {14668,    "711c",                   "bwtilebroth"           },
    {14668,    "711c",                   "CJ_CHIP_M2"            },
    {14668,    "711c",                   "cj_white_wall2"        },
    {14668,    "711c",                   "gun_ceiling1128"       },
    {14668,    "711c",                   "gun_ceiling3"          },
    {9514,     "711_sfw",                "brick"                 },
    {9514,     "711_sfw",                "mono1_sfe"             },
    {9514,     "711_sfw",                "mono2_sfe"             },
    {9514,     "711_sfw",                "pcut_bot_law"          },
    {9514,     "711_sfw",                "rebrckwall_128"        },
    {9514,     "711_sfw",                "shingles2"             },
    {9514,     "711_sfw",                "supasave_sfw"          },
    {9514,     "711_sfw",                "ws_carpark2"           },
    {1560,     "7_11_door",              "CJ_CHROME2"            },
    {1560,     "7_11_door",              "cj_sheetmetal2"        },
    {14690,    "7_11_posters",           "CJ_7_11_POST"          },
    {14690,    "7_11_posters",           "CJ_7_11_POST2"         },
    {14690,    "7_11_posters",           "cokopops_1"            },
    {14690,    "7_11_posters",           "munkyJuice_2"          },
    {13659,    "8bars",                  "AH_gbarrier"           },
    {16640,    "a51",                    "Alumox64"              },
    {16640,    "a51",                    "banding3c_64HV"        },
    {16640,    "a51",                    "concretegroundl1_256"  },
    {16640,    "a51",                    "concretemanky"         },
    {16640,    "a51",                    "concreteyellow256 copy"},
    {16640,    "a51",                    "des_factower"          },
    {16640,    "a51",                    "Metal3_128"            },
    {16640,    "a51",                    "metpat64"              },
    {16640,    "a51",                    "pavegrey128"           },
    {16640,    "a51",                    "scratchedmetal"        },
    {16640,    "a51",                    "stormdrain7"           },
    {16640,    "a51",                    "vgs_shopwall01_128"    },
    {16640,    "a51",                    "wallgreyred128"        },
    {16640,    "a51",                    "ws_stationfloor"       },
    {3095,     "a51jdrx",                "sam_camo"              },
    {16644,    "a51_detailstuff",        "steel256128"           },
    {16093,    "a51_ext",                "block2_high"           },
    {16093,    "a51_ext",                "cabin5"                },
    {16093,    "a51_ext",                "stormdrain2_nt"        },
    {16093,    "a51_ext",                "ws_trans_concr"        },
    {16093,    "a51_ext",                "ws_whitewall2_bottom"  },
    {16093,    "a51_ext",                "ws_whitewall2_top"     },
    {2951,     "a51_labdoor",            "washapartwall1_256"    },
    {16639,    "a51_labs",               "ws_trainstationwin1"   },
    {16322,    "a51_stores",             "des_ghotwood1"         },
    {16322,    "a51_stores",             "metalic128"            },
    {16322,    "a51_stores",             "steel64"               },
    {2567,     "ab",                     "chipboard_256"         },
    {14615,    "abatoir_daylite",        "ab_volumelight"        },
    {14584,    "ab_abbatoir01",          "ab_wall1b"             },
    {14584,    "ab_abbatoir01",          "carpet5kb"             },
    {14584,    "ab_abbatoir01",          "cj_sheetmetal"         },
    {11150,    "ab_acc_control",         "ws_shipmetal5"         },
    {2755,     "ab_dojowall",            "mp_apt1_roomfloor"     },
    {14581,    "ab_mafiasuitea",         "ab_blind"              },
    {14581,    "ab_mafiasuitea",         "ab_pic_bridge"         },
    {14581,    "ab_mafiasuitea",         "ab_wood01"             },
    {14581,    "ab_mafiasuitea",         "barbersmir1"           },
    {14581,    "ab_mafiasuitea",         "carp01S"               },
    {14581,    "ab_mafiasuitea",         "cof_wood2"             },
    {14581,    "ab_mafiasuitea",         "walp45S"               },
    {14581,    "ab_mafiasuitea",         "wood02S"               },
    {2591,     "ab_partition1",          "ab_fabricCheck2"       },
    {18065,    "ab_sfammumain",          "ab_stripped_floor"     },
    {18065,    "ab_sfammumain",          "ab_wallpaper02"        },
    {18065,    "ab_sfammumain",          "breezewall"            },
    {18065,    "ab_sfammumain",          "carp20S"               },
    {18065,    "ab_sfammumain",          "gun_ceiling1"          },
    {18065,    "ab_sfammumain",          "gun_floor1"            },
    {18065,    "ab_sfammumain",          "gun_floor2"            },
    {18065,    "ab_sfammumain",          "plywood_gym"           },
    {18065,    "ab_sfammumain",          "shelf_glas"            },
    {18064,    "ab_sfammuunits",         "rubber_mat"            },
    {14786,    "ab_sfgymbeams",          "gym_floor5"            },
    {14786,    "ab_sfgymbeams",          "knot_wood128"          },
    {14788,    "ab_sfgymbits01",         "ab_rollmat01"          },
    {14788,    "ab_sfgymbits01",         "lockers"               },
    {14787,    "ab_sfgymbits02",         "ab_rollmat02"          },
    {14789,    "ab_sfgymmain",           "ab_panelWall1"         },
    {14789,    "ab_sfgymmain",           "ab_panelWall2"         },
    {14789,    "ab_sfgymmain",           "ab_wood02"             },
    {14789,    "ab_sfgymmain",           "gymwinodow3"           },
    {14789,    "ab_sfgymmain",           "gym_floor6"            },
    {14652,    "ab_trukstpa",            "bbar_wall1"            },
    {14652,    "ab_trukstpa",            "bbar_wall4"            },
    {14652,    "ab_trukstpa",            "CJ_CORD"               },
    {14652,    "ab_trukstpa",            "CJ_WOOD1(EDGE)"        },
    {14652,    "ab_trukstpa",            "CJ_WOOD6"              },
    {14652,    "ab_trukstpa",            "mp_diner_wood"         },
    {14652,    "ab_trukstpa",            "wood01"                },
    {14650,    "ab_trukstpc",            "mp_CJ_WOOD5"           },
    {14650,    "ab_trukstpc",            "sa_wood08_128"         },
    {14651,    "ab_trukstpd",            "Bow_bar_flooring"      },
    {14651,    "ab_trukstpd",            "Bow_bar_tabletop_wood" },
    {14654,    "ab_trukstpe",            "bbar_plates2"          },
    {14654,    "ab_trukstpe",            "bbar_signs1"           },
    {14654,    "ab_trukstpe",            "bbar_sports1"          },
    {14654,    "ab_trukstpe",            "bbar_stuff1"           },
    {14654,    "ab_trukstpe",            "bbar_stuff3"           },
    {14654,    "ab_trukstpe",            "bbar_stuff9"           },
    {14486,    "ab_vegasgymbits01",      "bbar_wall2"            },
    {14794,    "ab_vegasgymmain",        "studiowall2_law"       },
    {14534,    "ab_wooziea",             "ab_tileDiamond"        },
    {14534,    "ab_wooziea",             "mcstraps_window"       },
    {14534,    "ab_wooziea",             "walp72S"               },
    {14535,    "ab_wooziec",             "ab_wallpaper01"        },
    {14535,    "ab_wooziec",             "ab_woodborder"         },
    {3080,     "adjumpx",                "gen_chrome"            },
    {10839,    "aircarpkbarier_sfse",    "cratetop128"           },
    {4835,     "airoads_las",            "weewall256"            },
    {4835,     "airoads_las",            "ws_carparkwall1"       },
    {4830,     "airport2",               "bathtile01_int"        },
    {4830,     "airport2",               "LASLACMA93"            },
    {4830,     "airport2",               "sanairtex3"            },
    {4830,     "airport2",               "sanpedock5"            },
    {4828,     "airport3_las",           "alax1_las"             },
    {4828,     "airport3_las",           "mirrwind1_LAn"         },
    {10811,    "airportbits_sfse",       "ap_fuel3"              },
    {10811,    "airportbits_sfse",       "brckwhtwash128"        },
    {10778,    "airportcpark_sfse",      "elecbox2"              },
    {10765,    "airportgnd_sfse",        "ws_whiteplaster_top"   },
    {10765,    "airportgnd_sfse",        "ws_whitestripe"        },
    {10755,    "airportrminl_sfse",      "ws_airportwall1"       },
    {10755,    "airportrminl_sfse",      "ws_airportwall2"       },
    {10755,    "airportrminl_sfse",      "ws_rotten_concrete1"   },
    {4833,     "airprtrunway_las",       "dockwall1"             },
    {2772,     "airp_prop",              "CJ_red_COUNTER"        },
    {10370,    "alleys_sfs",             "ws_sandstone1"         },
    {4552,     "ammu_lan2",              "newall4-4"             },
    {4552,     "ammu_lan2",              "sl_lavicdtwall1"       },
    {9920,     "anotherbuildsfe",        "gz_vic1e"              },
    {9920,     "anotherbuildsfe",        "gz_vic2d"              },
    {3881,     "apsecurity_sfxrf",       "CJ_WOOD1"              },
    {3881,     "apsecurity_sfxrf",       "ws_altz_wall10"        },
    {3881,     "apsecurity_sfxrf",       "ws_rooftarmac2"        },
    {10041,    "archybuild10",           "bank_sfe5"             },
    {10850,    "bakerybit2_sfse",        "ws_altz_wall5"         },
    {10856,    "bakerybit_sfse",         "ws_altz_wall7"         },
    {10856,    "bakerybit_sfse",         "ws_dickgoblinmural"    },
    {10856,    "bakerybit_sfse",         "ws_oldwarehouse10a"    },
    {10856,    "bakerybit_sfse",         "ws_oldwarehouse10d"    },
    {10891,    "bakery_sfse",            "ws_altz_wall4"         },
    {3437,     "ballypillar01",          "ballywall01_64"        },
    {8391,     "ballys01",               "ballywall02_128"       },
    {8391,     "ballys01",               "ws_floortiles4"        },
    {5397,     "barrio1_lae",            "cargo7_128"            },
    {17508,    "barrio1_lae2",           "brickred"              },
    {3452,     "bballvgnint",            "bballconcrete1_256"    },
    {3452,     "bballvgnint",            "bballconcrete2_256"    },
    {3452,     "bballvgnint",            "bballconcrete3_256"    },
    {3452,     "bballvgnint",            "bballconcrete4_256"    },
    {3452,     "bballvgnint",            "bballconcrete5_256"    },
    {5520,     "bdupshouse_lae",         "comptwall23"           },
    {14803,    "bdupsnew",               "Bdup2_carpet"          },
    {14803,    "bdupsnew",               "Bdup2_poster"          },
    {14803,    "bdupsnew",               "Bdup2_Rug"             },
    {14803,    "bdupsnew",               "Bdup2_wallpaper"       },
    {14803,    "bdupsnew",               "Bdup2_wallpaperB"      },
    {3653,     "beachapts_lax",          "Bow_dryclean_wall_upr" },
    {3653,     "beachapts_lax",          "Ind_Roadskank"         },
    {3615,     "beachhut",               "sw_flatroof01"         },
    {3615,     "beachhut",               "ws_decking1"           },
    {17953,    "beach_lae2",             "block2_low"            },
    {4811,     "beach_las",              "sandnew_law"           },
    {4811,     "beach_las",              "sandstonemixb"         },
    {4811,     "beach_las",              "sm_Agave_bloom"        },
    {10351,    "beach_sfs",              "rocktb128"             },
    {6312,     "beacliff_law2",          "redclifftop256"        },
    {6312,     "beacliff_law2",          "sm_rock2_desert"       },
    {6404,     "beafron1_law2",          "compfence7_LAe"        },
    {6404,     "beafron1_law2",          "comptwall30"           },
    {6404,     "beafron1_law2",          "comptwall31"           },
    {6404,     "beafron1_law2",          "Gen_Scaffold_Wood_Under"},
    {6404,     "beafron1_law2",          "melroran3_law"         },
    {6404,     "beafron1_law2",          "pierbild01_law"        },
    {6404,     "beafron1_law2",          "shutter02LA"           },
    {6282,     "beafron2_law2",          "boardwalk2_la"         },
    {6282,     "beafron2_law2",          "comptwall33"           },
    {6282,     "beafron2_law2",          "decoacwallbtmb21_256"  },
    {6282,     "beafron2_law2",          "sanpiz1"               },
    {6282,     "beafron2_law2",          "shutter03LA"           },
    {6282,     "beafron2_law2",          "sjmcargr"              },
    {1281,     "benches",                "pierdoor02_law"        },
    {11100,    "bendytunnel_sfse",       "blackmetal"            },
    {11100,    "bendytunnel_sfse",       "Bow_sub_wallshine"     },
    {11100,    "bendytunnel_sfse",       "Bow_sub_walltiles"     },
    {11100,    "bendytunnel_sfse",       "ws_altz_wall10b"       },
    {13691,    "bevcunto2_lahills",      "adeta"                 },
    {13691,    "bevcunto2_lahills",      "crazypave"             },
    {13691,    "bevcunto2_lahills",      "stonewall3_la"         },
    {13691,    "bevcunto2_lahills",      "ws_floortiles2"        },
    {3603,     "bevmans01_la",           "cemebuild03_law"       },
    {3603,     "bevmans01_la",           "garagedoor4_law"       },
    {3603,     "bevmans01_la",           "pavepat2_128"          },
    {3603,     "bevmans01_la",           "sjmlahus21"            },
    {3603,     "bevmans01_la",           "sjmlahus29"            },
    {6284,     "bev_law2",               "pierbild04_law"        },
    {6284,     "bev_law2",               "pierwall02_law"        },
    {9515,     "bigboxtemp1",            "poshground_sfw"        },
    {9515,     "bigboxtemp1",            "redbrickground256"     },
    {9515,     "bigboxtemp1",            "sf_concrete1"          },
    {10056,    "bigoldbuild_sfe",        "alleys_sfe"            },
    {10056,    "bigoldbuild_sfe",        "sfe_arch1"             },
    {10056,    "bigoldbuild_sfe",        "sf_backaley1"          },
    {10056,    "bigoldbuild_sfe",        "sf_windos_13wall"      },
    {15041,    "bigsfsave",              "ah_ceilpan1"           },
    {15041,    "bigsfsave",              "AH_flrdiamonds"        },
    {15041,    "bigsfsave",              "AH_flroortile5"        },
    {15041,    "bigsfsave",              "AH_flroortile9"        },
    {15041,    "bigsfsave",              "AH_strntiles"          },
    {15041,    "bigsfsave",              "ah_utilbor1"           },
    {15041,    "bigsfsave",              "ah_utilbor2"           },
    {15041,    "bigsfsave",              "AH_walltile6"          },
    {15041,    "bigsfsave",              "AH_wdpanscum"          },
    {15041,    "bigsfsave",              "ah_wpaper7"            },
    {15041,    "bigsfsave",              "mp_carter_tilewall"    },
    {15041,    "bigsfsave",              "wall6"                 },
    {15041,    "bigsfsave",              "walp73S"               },
    {9583,     "bigshap_sfw",            "boatfunnel1_128"       },
    {9583,     "bigshap_sfw",            "bridge_walls2_sfw"     },
    {9583,     "bigshap_sfw",            "bridge_walls3_sfw"     },
    {10023,    "bigwhitesfe",            "archgrnd1_SFE"         },
    {10023,    "bigwhitesfe",            "recessed_light_SF"     },
    {10023,    "bigwhitesfe",            "sfe_arch10"            },
    {10023,    "bigwhitesfe",            "sfe_arch2"             },
    {14603,    "bikeskool",              "motel_wall3"           },
    {3083,     "billbox",                "ADDWOOD"               },
    {3922,     "bistro",                 "ahoodfence2"           },
    {3922,     "bistro",                 "barbersflr1_LA"        },
    {3922,     "bistro",                 "DinerFloor"            },
    {3922,     "bistro",                 "Marble"                },
    {3922,     "bistro",                 "Marble2"               },
    {3922,     "bistro",                 "marblekb_256128"       },
    {3922,     "bistro",                 "mp_snow"               },
    {3922,     "bistro",                 "sw_wallbrick_01"       },
    {10871,    "blacksky_sfse",          "ws_altz_wall7_top"     },
    {9524,     "blokmodb",               "Bow_Grimebrick"        },
    {9524,     "blokmodb",               "lightwallv256"         },
    {9524,     "blokmodb",               "lombard_build1_4"      },
    {5042,     "bombshop_las",           "greymetal"             },
    {3820,     "boxhses_sfsx",           "stonewall_la"          },
    {3820,     "boxhses_sfsx",           "ws_blocks_grey_1"      },
    {3820,     "boxhses_sfsx",           "ws_blocks_red_1"       },
    {3820,     "boxhses_sfsx",           "ws_green_wall1"        },
    {3820,     "boxhses_sfsx",           "ws_pink_wall1"         },
    {9507,     "boxybld2_sfw",           "dirty01"               },
    {9507,     "boxybld2_sfw",           "gz_vic4c"              },
    {9507,     "boxybld2_sfw",           "sfn_rock2"             },
    {9496,     "boxybld_sfw",            "boxybox_sf5bz"         },
    {9496,     "boxybld_sfw",            "taxi_256"              },
    {9496,     "boxybld_sfw",            "ws_altz_wall8_bot"     },
    {1453,     "break_farm",             "CJ_DarkWood"           },
    {1453,     "break_farm",             "cj_hay2"               },
    {1408,     "break_fence1",           "CJ_W_wood"             },
    {1407,     "break_f_w",              "CJ_SLATEDWOOD"         },
    {1422,     "break_road",             "CJ_W_BALL"             },
    {1459,     "break_road_ws",          "CJ_SHEET2"             },
    {1426,     "break_scaffold",         "CJ_BLUE_WOOD"          },
    {1355,     "break_s_bins",           "CJ_RED_LEATHER"        },
    {10864,    "bridgeland_sfse",        "ws_altz_wall1"         },
    {4593,     "buildblk55",             "GB_nastybar03"         },
    {4593,     "buildblk55",             "sl_plazatile01"        },
    {4604,     "buildblk555",            "gm_labuld5_b"          },
    {5819,     "buildtestlawn",          "lawshopwall4"          },
    {1243,     "buoy",                   "buoyrust_128"          },
    {11092,    "burgalrystore_sfse",     "ws_peeling_ceiling2"   },
    {2212,     "burger_tray",            "bkidside"              },
    {2212,     "burger_tray",            "btdeck256"             },
    {2212,     "burger_tray",            "burgerfries"           },
    {2212,     "burger_tray",            "burgertop"             },
    {2212,     "burger_tray",            "fries_cb"              },
    {6257,     "burgsh01_law",           "newall2"               },
    {14383,    "burg_1",                 "burglry_wall3"         },
    {14383,    "burg_1",                 "carpet4kb"             },
    {14383,    "burg_1",                 "curtain_sink2"         },
    {14383,    "burg_1",                 "hospital_wall2"        },
    {14383,    "burg_1",                 "kit_windo_12"          },
    {14383,    "burg_1",                 "wallpapkb1"            },
    {17545,    "burnsground",            "bluapartwall1_256"     },
    {17545,    "burnsground",            "dirtyredwall512"       },
    {17545,    "burnsground",            "indund_64"             },
    {17545,    "burnsground",            "newall1-1128"          },
    {17545,    "burnsground",            "newall10_seamless"     },
    {1257,     "bustopm",                "CJ_GREENMETAL"         },
    {10143,    "calfed_sfe",             "calfederal7"           },
    {6094,     "canalsg_law",            "block2bb"              },
    {6094,     "canalsg_law",            "sw_brewbrick01"        },
    {6094,     "canalsg_law",            "ws_sheetwood_clean"    },
    {642,      "canopy",                 "weathered wood2 64HV"  },
    {642,      "canopy",                 "wood02"                },
    {5766,     "capitol_lawn",           "alleygroundb256"       },
    {5766,     "capitol_lawn",           "capitol1_LAwN"         },
    {5766,     "capitol_lawn",           "capitol3_LAwN"         },
    {5766,     "capitol_lawn",           "hilcouwall2"           },
    {5766,     "capitol_lawn",           "vgs_whitewall_128"     },
    {10051,    "carimpound_sfe",         "poundwall1_sfe"        },
    {14476,    "carlslounge",            "ah_blu_paper"          },
    {14476,    "carlslounge",            "ah_blu_paper2"         },
    {14476,    "carlslounge",            "AH_cheapredcarpet"     },
    {14476,    "carlslounge",            "AH_plnskirting"        },
    {14489,    "carlspics",              "ah_bdflwd"             },
    {14489,    "carlspics",              "AH_flroortile7"        },
    {14489,    "carlspics",              "AH_landscap1"          },
    {14489,    "carlspics",              "AH_landscap3"          },
    {14489,    "carlspics",              "AH_picture2"           },
    {14489,    "carlspics",              "AH_picture3"           },
    {14489,    "carlspics",              "AH_picture4"           },
    {14489,    "carlspics",              "AH_wdpanelend"         },
    {14471,    "carls_kit1",             "barbersflr1"           },
    {14471,    "carls_kit1",             "wall1"                 },
    {14471,    "carls_kit1",             "wall7"                 },
    {14472,    "carls_kit2",             "curtain_sinkb"         },
    {8420,     "carpark3_lvs",           "Corner1_128"           },
    {9254,     "carparkssfn",            "decoacwallbtm1_256"    },
    {11145,    "carrierint_sfs",         "ws_floor2"             },
    {11301,    "carshow_sfse",           "concpanel_la"          },
    {11301,    "carshow_sfse",           "concreteslab_small"    },
    {11301,    "carshow_sfse",           "ws_officy_ceiling"     },
    {14407,    "carter_block",           "mp_carter_ceiling"     },
    {14407,    "carter_block",           "mp_carter_smoothwall"  },
    {14407,    "carter_block",           "mp_carter_wall"        },
    {14407,    "carter_block",           "mp_carter_wallbot"     },
    {14407,    "carter_block",           "mp_carter_whitewall"   },
    {14407,    "carter_block",           "zebra_skin"            },
    {14415,    "carter_block_2",         "cd_wall1"              },
    {14415,    "carter_block_2",         "mp_carter_wallpaper"   },
    {14415,    "carter_block_2",         "mp_gs_woodpanel"       },
    {14415,    "carter_block_2",         "mp_motel_carpet1"      },
    {17933,    "carter_mainmap",         "mp_carter_carpet"      },
    {14466,    "carter_outside",         "mp_carter_corrwall"    },
    {7088,     "casinoshops1",           "247sign1"              },
    {14577,    "casinovault01",          "ab_corWallLwr"         },
    {14577,    "casinovault01",          "ab_mottleSteps"        },
    {14577,    "casinovault01",          "cof_wood1"             },
    {14577,    "casinovault01",          "copbtm_brown"          },
    {14577,    "casinovault01",          "vaultWall"             },
    {2176,     "casino_props",           "marblebox"             },
    {14582,    "casmafbar",              "ab_CasRomTile1"        },
    {10368,    "cathedral_sfs",          "dirt64b2"              },
    {2343,     "cb_bar_bits",            "CJ_POLISHED"           },
    {2767,     "cb_details",             "pattern1_cb"           },
    {13139,    "cecuntetunnel",          "conc_wall_stripd128H"  },
    {13139,    "cecuntetunnel",          "dirtywall_256"         },
    {5710,     "cemetery_law",           "brickgrey"             },
    {5710,     "cemetery_law",           "conc_wall2_128H"       },
    {5710,     "cemetery_law",           "desmud"                },
    {1597,     "centralresac1",          "kbbark_test1"          },
    {13363,    "cephotoblockcs_t",       "sw_wall_05"            },
    {13364,    "cetown3cs_t",            "floor_tileone_256"     },
    {13364,    "cetown3cs_t",            "pierboards_la"         },
    {13364,    "cetown3cs_t",            "sw_barnwood2"          },
    {13364,    "cetown3cs_t",            "sw_slate01"            },
    {13364,    "cetown3cs_t",            "sw_wall03"             },
    {12946,    "ce_bankalley1",          "alleywall3"            },
    {12946,    "ce_bankalley1",          "sjmALLEY"              },
    {12946,    "ce_bankalley1",          "sw_brick03"            },
    {12946,    "ce_bankalley1",          "sw_warewall"           },
    {12944,    "ce_bankalley2",          "sw_brick04"            },
    {12822,    "ce_bankalley3",          "sw_Fleishberg01"       },
    {3314,     "ce_burbhouse",           "notice02"              },
    {3314,     "ce_burbhouse",           "shingles4"             },
    {3314,     "ce_burbhouse",           "sw_lattice"            },
    {3314,     "ce_burbhouse",           "sw_wallbrick_06"       },
    {3374,     "ce_farmxref",            "sw_barnwood4"          },
    {3374,     "ce_farmxref",            "sw_barnwood5"          },
    {3374,     "ce_farmxref",            "sw_woodflloorsplat"    },
    {12871,    "ce_ground01",            "cs_rockdetail2"        },
    {13235,    "ce_ground09",            "des_ranchwall1"        },
    {12978,    "ce_payspray",            "sw_shedwall03"         },
    {13361,    "ce_pizza",               "brickred2"             },
    {13003,    "ce_racestart",           "CJ_TARTAN"             },
    {13003,    "ce_racestart",           "sa_wood07_128"         },
    {13295,    "ce_terminal",            "whitewall256"          },
    {11089,    "cf_metals_sfse",         "ws_altz_wall8_top"     },
    {1594,     "chairsntable",           "mallfloor6"            },
    {5986,     "chateau_lawn",           "chatwall01_law"        },
    {5986,     "chateau_lawn",           "chatwall03_law"        },
    {5123,     "chemgrnd_las2",          "newall1-1"             },
    {5444,     "chicano10_lae",          "comptwall10"           },
    {5444,     "chicano10_lae",          "comptwall15"           },
    {5444,     "chicano10_lae",          "comptwall32"           },
    {5444,     "chicano10_lae",          "comptwall5"            },
    {5444,     "chicano10_lae",          "crakwall1_LAe2"        },
    {5444,     "chicano10_lae",          "g_256"                 },
    {5444,     "chicano10_lae",          "newall7"               },
    {10031,    "chinatown2",             "ws_red_wood2"          },
    {8639,     "chinatownmall",          "ctmall02_64"           },
    {8639,     "chinatownmall",          "ctmall03_64"           },
    {8639,     "chinatownmall",          "ctmall12_128"          },
    {8639,     "chinatownmall",          "ctmall15_128"          },
    {8639,     "chinatownmall",          "ctmall17_128"          },
    {9494,     "chinatownsfe",           "chtown6_sf"            },
    {9494,     "chinatownsfe",           "chtown_brightcarcafe"  },
    {9494,     "chinatownsfe",           "chtown_todaydayrestaurant" },
    {9494,     "chinatownsfe",           "rooftop_gz1"           },
    {9494,     "chinatownsfe",           "sf_windos_12_wall"     },
    {14571,    "chinese_furn",           "ab_tv_tricas2"         },
    {14571,    "chinese_furn",           "chinese9"              },
    {14571,    "chinese_furn",           "chinese9b"             },
    {1859,     "chips2",                 "chip_stck1"            },
    {1859,     "chips2",                 "chip_stck2"            },
    {1859,     "chips2",                 "chip_stck3"            },
    {14674,    "civic02cj",              "ab_hosWallUpr"         },
    {14674,    "civic02cj",              "hotcarp01_LA"          },
    {3967,     "cj_airprt",              "CJ_RUBBER"             },
    {3967,     "cj_airprt",              "dts_elevator_carpet2"  },
    {3967,     "cj_airprt",              "Road_blank256HV"       },
    {1736,     "cj_ammo",                "Star   aluminuim"      },
    {2059,     "cj_ammo2",               "CJ_gunbook1"           },
    {2059,     "cj_ammo2",               "CJ_gunbook2"           },
    {2059,     "cj_ammo2",               "cj_rubbish2"           },
    {2068,     "cj_ammo_net",            "CJ_cammonet"           },
    {2047,     "cj_ammo_posters",        "CJ_Coltposter"         },
    {2047,     "cj_ammo_posters",        "cj_flag1"              },
    {2047,     "cj_ammo_posters",        "cj_flag2"              },
    {2047,     "cj_ammo_posters",        "CJ_TARGET1"            },
    {2047,     "cj_ammo_posters",        "CJ_TARGET2"            },
    {2047,     "cj_ammo_posters",        "CJ_TARGET3"            },
    {18034,    "cj_ammun_extra",         "CJ_BULLETBOX2"         },
    {18034,    "cj_ammun_extra",         "CJ_BULLETBOX2b"        },
    {18034,    "cj_ammun_extra",         "CJ_BULLETBOX2c"        },
    {18034,    "cj_ammun_extra",         "CJ_BULLETBOX3"         },
    {18034,    "cj_ammun_extra",         "CJ_BULLETBOXB"         },
    {18034,    "cj_ammun_extra",         "CJ_BULLETBOXB2"        },
    {18034,    "cj_ammun_extra",         "CJ_GRIZ"               },
    {18034,    "cj_ammun_extra",         "CJ_NAIL_AMMO"          },
    {18034,    "cj_ammun_extra",         "CJ_TAR1"               },
    {18034,    "cj_ammun_extra",         "mp_gun_box"            },
    {18034,    "cj_ammun_extra",         "mp_gun_neon"           },
    {2783,     "cj_bandit",              "slot6"                 },
    {2783,     "cj_bandit",              "slot_bit3"             },
    {2655,     "cj_banner",              "CJ_ERIS1"              },
    {2655,     "cj_banner",              "CJ_HEAT1"              },
    {2655,     "cj_banner",              "CJ_HEAT2"              },
    {2655,     "cj_banner",              "CJ_MERC_LOGO"          },
    {2655,     "cj_banner",              "CJ_PRO_2"              },
    {2655,     "cj_banner",              "CJ_SUBURBAN_1"         },
    {2692,     "cj_banner2",             "CJ_CARDBOARD"          },
    {2719,     "cj_banner3",             "CJ_BINC_1"             },
    {2719,     "cj_banner3",             "CJ_BINC_2"             },
    {2719,     "cj_banner3",             "CJ_BINC_3"             },
    {1455,     "cj_bar",                 "CJ_BAR_BOTTLE1"        },
    {1455,     "cj_bar",                 "CJ_BAR_TAP1"           },
    {1455,     "cj_bar",                 "CJ_BAR_TAP2"           },
    {1455,     "cj_bar",                 "CJ_B_TOWEL"            },
    {1455,     "cj_bar",                 "cj_b_tray"             },
    {1455,     "cj_bar",                 "CJ_old_pish"           },
    {1455,     "cj_bar",                 "CJ_SK_Bar"             },
    {1455,     "cj_bar",                 "CJ_SK_DIET_Bar"        },
    {18028,    "cj_bar2",                "bbar_stuff2"           },
    {18028,    "cj_bar2",                "CJ_nastybar_D"         },
    {18028,    "cj_bar2",                "CJ_nastybar_D2"        },
    {18028,    "cj_bar2",                "CJ_nastybar_D3"        },
    {18028,    "cj_bar2",                "CJ_nastybar_D4"        },
    {18028,    "cj_bar2",                "CJ_nastybar_D5"        },
    {18028,    "cj_bar2",                "CJ_nastybar_D6"        },
    {18028,    "cj_bar2",                "GB_nastybar01"         },
    {18028,    "cj_bar2",                "GB_nastybar02"         },
    {18028,    "cj_bar2",                "GB_nastybar04"         },
    {18028,    "cj_bar2",                "GB_nastybar05"         },
    {18028,    "cj_bar2",                "GB_nastybar06"         },
    {18028,    "cj_bar2",                "GB_nastybar07"         },
    {18028,    "cj_bar2",                "GB_nastybar08"         },
    {18028,    "cj_bar2",                "GB_nastybar09"         },
    {18028,    "cj_bar2",                "GB_nastybar10"         },
    {18028,    "cj_bar2",                "GB_nastybar13"         },
    {18028,    "cj_bar2",                "GB_nastybar15"         },
    {18028,    "cj_bar2",                "GB_nastybar17"         },
    {18081,    "cj_barb",                "ab_drawer_unit2"       },
    {18081,    "cj_barb",                "ab_leather_strips"     },
    {18081,    "cj_barb",                "ab_marble_checks"      },
    {18081,    "cj_barb",                "ab_panel_woodgrime"    },
    {18081,    "cj_barb",                "ab_sink_barber"        },
    {18081,    "cj_barb",                "ab_window_plastic"     },
    {18081,    "cj_barb",                "barberschr1"           },
    {18081,    "cj_barb",                "barberschr2"           },
    {18081,    "cj_barb",                "barberschr3"           },
    {18081,    "cj_barb",                "barberschr4"           },
    {18081,    "cj_barb",                "barberschr5"           },
    {18081,    "cj_barb",                "barberschr6"           },
    {18081,    "cj_barb",                "barberschr7b"          },
    {18081,    "cj_barb",                "barberspic1"           },
    {18081,    "cj_barb",                "barberspic2"           },
    {18081,    "cj_barb",                "barberspic3"           },
    {18081,    "cj_barb",                "CJ_TILES_5"            },
    {2514,     "cj_bathroom",            "CJ_CANVAS"             },
    {2423,     "cj_ff_counters",         "CJ_Laminate1"          },
    {1730,     "cj_furniture",           "CJ_WOOD5"              },
    {2127,     "cj_kitchen",             "CJ_RED"                },
    {1731,     "cj_lighting",            "CJ_PLANT_POT"          },
    {1701,     "cj_med_beds",            "CJ_DUVET1"             },
    {1701,     "cj_med_beds",            "CJ_LINEN1"             },
    {1714,     "cj_office",              "beige_64"              },
    {1714,     "cj_office",              "BLUE_FABRIC"           },
    {1714,     "cj_office",              "la_kitch3"             },
    {1714,     "cj_office",              "redFabric"             },
    {1746,     "cj_sofa",                "CJ_FAB1"               },
    {1737,     "cj_tables",              "FORMICA1"              },
    {1717,     "cj_tv",                  "CJ_STEEL"              },
    {2381,     "cloth_trackies",         "trackTr"               },
    {17562,    "coast_apts",             "sunsetmall03b_law"     },
    {2950,     "col_wallx",              "gangwall2"             },
    {3555,     "comedhos1_la",           "dock1"                 },
    {3241,     "conhooses",              "des_dustconc"          },
    {1977,     "cooler1",                "kb_vend2"              },
    {6487,     "councl_law2",            "tarmacplain2_bank"     },
    {11013,    "crackdrive_sfse",        "ws_asphalt2"           },
    {11088,    "crackfactdem_sfs",       "ws_altz_wall7_top_burn"},
    {8481,     "csrsfence01",            "ceaserwall06_128"      },
    {6522,     "cuntclub_law2",          "helipad_grey1"         },
    {3306,     "cunte_house1",           "des_ntwnwall1"         },
    {17092,    "cuntwlandcarparks",      "sw_sandgrass4"         },
    {18233,    "cuntwshopscs_t",         "orange1"               },
    {18233,    "cuntwshopscs_t",         "vgngewall1_256"        },
    {18242,    "cw_motel2cs_t",          "des_motelwall3"        },
    {3292,     "cxrf_payspray",          "sf_spray1"             },
    {3887,     "dem4_sfxrf",             "ws_peeling_ceiling2_smoked"},
    {16398,    "desn2_peckers",          "tarp_law"              },
    {16071,    "des_quarrybelts",        "sjmlawarwall5"         },
    {3595,     "dingbat01_la",           "comptwall20"           },
    {5154,     "dkcargoshp_las2",        "green_64"              },
    {17555,    "eastbeach3c_lae2",       "decobuild2d_LAn"       },
    {17547,    "eastbeach4a_lae2",       "ltgreenwallc1"         },
    {17547,    "eastbeach4a_lae2",       "sand256"               },
    {8498,     "excalibur",              "excaliburwall01_128"   },
    {14443,    "ganghoos",               "mp_burn_carpet"        },
    {14443,    "ganghoos",               "mp_burn_carpet1"       },
    {14443,    "ganghoos",               "mp_burn_carpet2"       },
    {14443,    "ganghoos",               "mp_burn_carpet3"       },
    {2821,     "gb_foodwrap01",          "sm_marble"             },
    {14846,    "genintintpoliceb",       "p_floor3"              },
    {14708,    "labig1int2",             "HS_art"                },
    {14706,    "labig2int2",             "HS3_wall2"             },
    {14707,    "labig3int2",             "HS2_3Wall5"            },
    {14707,    "labig3int2",             "HS_art8"               },
    {14707,    "labig3int2",             "WH_walls"              },
    {15048,    "labigsave",              "ah_carp1"              },
    {15048,    "labigsave",              "ah_carpet2kb"          },
    {15048,    "labigsave",              "AH_carpet4kb"          },
    {15048,    "labigsave",              "AH_flroortile1"        },
    {17519,    "lae2newtempbx",          "sanpedpawn1"           },
    {14712,    "lahss2bint2",            "HS3_wall8"             },
    {14701,    "lahss2int2",             "HS1_Kwall"             },
    {14832,    "lee_stripclub",          "cl_floornew_256"       },
    {14839,    "lee_strippriv",          "WH_Sofa"               },
    {5732,     "melrose12_lawn",         "comptwall39"           },
    {18058,    "mp_diner2",              "mp_diner_floordirt"    },
    {14735,    "newcrak",                "carpet-tile"           },
    {6095,     "shops01_law",            "GB_chatwall03b"        },
    {4550,     "skyscr1_lan2",           "sl_skyscrpr02wall1"    },
    {4568,     "skyscrap2_lan2",         "sl_marblewall2"        },
    {4570,     "stolenbuild03",          "sl_dtbuild2wall1"      },
    {4570,     "stolenbuild03",          "sl_dtbuild2win1"       },
    {6871,     "vegascourtbld",          "courthsedor2_256"      },
    {14714,    "vghss1int2",             "HS4_Wall5"             },
    {6988,     "vgnfremnt1",             "scmgarage1_128"        },
    {6985,     "vgnfremnt2",             "striplightsblu_256"    },
    {6985,     "vgnfremnt2",             "striplightsgreen_256"  },
    {6985,     "vgnfremnt2",             "striplightsorange_256" },
    {6985,     "vgnfremnt2",             "striplightspinky_256"  },
    {6985,     "vgnfremnt2",             "striplightsred_256"    },
    {6985,     "vgnfremnt2",             "striplightsyel_256"    },
    {6922,     "vgnretail6",             "marinawindow2_256"     },
    {7489,     "vgntamotel",             "vgncoctart1_256"       },
    {14711,    "vgshm2int2",             "HS2_wall5"             },
    {14711,    "vgshm2int2",             "HSV_carpet2"           },
    {14710,    "vgshm3int2",             "HSV_3carpet2"          },
    {1319,     "ws_roadside_dyn1",       "ws_roadpost"           }
};

enum E_CHOUCH_OBJECT_DATA
{
    ceId,
    ceName[23],
    cePrice
}
new const ObjectsCouch[][E_CHOUCH_OBJECT_DATA] =
{
    {1702,     "Svijetlo smedi kauc"   ,    100},
    {1703,     "Crni kauc"             ,    100},
    {1706,     "Ljubicasti kauc"       ,    100},
    {1707,     "Lazybag kauc"          ,    100},
    {1709,     "Ugaona garnitura"      ,    150},
    {1710,     "Cetvorosed"            ,    100},
    {1712,     "Dvosjed"               ,    100},
    {1713,     "Plavi kauc"            ,    100},
    {1723,     "Crni kauc"             ,    150},
    {1726,     "Kauc - crna koza"      ,    250},
    {1728,     "Krem dvosed"           ,    100},
    {1753,     "Smedi trosed - koza"   ,    200},
    {1756,     "Ukraseni dvosed"       ,    100},
    {1757,     "Rozi dvosed"           ,    150},
    {1760,     "Plavi trosed"          ,    250},
    {1761,     "Smedi drveni trosed"   ,    100},
    {1763,     "Rozi dvosed - mali"    ,    100},
    {1764,     "Braon sofa"            ,    100},
    {1766,     "Siva sofa"             ,    100},
    {1768,     "Plavi trosed"          ,    100},
    {2290,     "Smedi sofa - trosed"   ,    150},
    {11685,    "Smedi kauc sa naslonom",    150}
};

enum E_ARMCHAIR_OBJECT_DATA
{
    armId,
    armName[33],
    armPrice
}
new const ObjectsArmChair[][E_ARMCHAIR_OBJECT_DATA] =
{
    {1704,    "Crna fotelja"               ,    100},
    {1705,    "Braon fotelja"              ,    100},
    {1708,    "Plava fotelja"              ,    100},
    {1711,    "Braon fotelja, garnitura"   ,    80},
    {1724,    "Crna fotelja, koza (drvena)",    100},
    {1727,    "Crna fotelja, koza"         ,    150},
    {1735,    "Visoka bela stolica"        ,    80},
    {1754,    "Braon garnitura"            ,    150},
    {1755,    "Svetloplava fotelja"        ,    100},
    {1758,    "Roza fotelja"               ,    100},
    {1765,    "Zuta garnitura"             ,    100},
    {1769,    "Plava fotelja, drvene drske",    120},
    {2096,    "Stolica za ljuljanje"       ,    75},
    {2292,    "Smedja kutna garnitura"     ,    200},
    {2295,    "Bagchair"                   ,    200},
    {2617,    "Bijele hotelske fotelje"    ,    200},
    {2571,    "Smedja hotelska fotelja"    ,    200},
    {2572,    "Bijele hotelske fotelje1"   ,    200}
};

enum E_CABINETS_OBJECT_DATA
{
    cabId,
    cabName[41],
    cabPrice
}
new const ObjectsCabinets[][E_CABINETS_OBJECT_DATA] =
{
    {2046,    "Orman za puske"                  ,    100},
    {2078,    "Starinski drveni orman"          ,    225},
    {2089,    "Drvena polica"                   ,    150},
    {2161,    "Puna niska polica za knjige"     ,    100},
    {2162,    "Prazna niska polica za knjige"   ,    100},
    {2163,    "Zatvoreni kancelarijski orman"   ,    150},
    {2164,    "Ormar sa policom za knjige"      ,    200},
    {2167,    "Uski kancelarijski orman"        ,    120},
    {2191,    "Plava polica za knjige"          ,    215},
    {2200,    "Veliki zatvoreni orman"          ,    225},
    {2204,    "Drvani ormar i policom za knjige",    225},
    {2063,    "Stare police"                    ,    225}
};

enum E_TELEVISION_OBJECT_DATA
{
    tvId,
    tvName[40],
    tvPrice
}
new const ObjectsTelevision[][E_TELEVISION_OBJECT_DATA] =
{
    {1429 ,    "Stari televizor"               ,    200},
    {1518 ,    "Stari televizor, crni"         ,    225},
    {1717 ,    "Televizor i stakleni stol"     ,    550},
    {1747 ,    "Stari televizor, drvena kutija",    250},
    {1748 ,    "Moderniji televizor"           ,    250},
    {1749 ,    "Camera TV"                     ,    250},
    {1750 ,    "Beli televizor"                ,    250},
    {1751 ,    "Moderniji beli televizor"      ,    300},
    {1752 ,    "Crni televizor"                ,    300},
    {1781 ,    "Kancelarijski televizor"       ,    280},
    {1791 ,    "Stariji crni televizor"        ,    280},
    {2091 ,    "Orman sa televizorom"          ,    550},
    {2093 ,    "Police sa televizorom"         ,    550},
    {2224 ,    "Moderan beli televizor"        ,    650},
    {2296 ,    "Orman sa televizorom i CD"     ,    550},
    {2297 ,    "Mali ormar sa televizorom i CD",    650},
    {2700 ,    "Zidni televizor"               ,    500},
    {-2038,    "LCD Televizor"                 ,    650},
    {1792 ,    "Moderni TV"                    ,    650},
    {19786,    "Velika plazma"                 ,    750},
    {19787,    "Plazma"                        ,    500}
};

enum E_HIFI_OBJECT_DATA
{
    hfId,
    hfName[45],
    hfPrice
}
new const ObjectsHiFi[][E_HIFI_OBJECT_DATA] =
{
    {1809 ,    "Kucno kino"                    ,    450},
    {2099 ,    "Drveni ormaric i tehnika1"     ,    550},
    {2010 ,    "Drveni ormaric i tehnika2"     ,    550},
    {2102 ,    "Crni zvucnici"                 ,    200},
    {2103 ,    "Beli radio"                    ,    150},
    {2104 ,    "Recording studio oprema"       ,    700},
    {2225 ,    "CD player i stakleni stol"     ,    350},
    {2226 ,    "Crveno-crni radio"             ,    300},
    {2227 ,    "Sound recorder i stakleni stol",    350},
    {1958 ,    "DJ set"                        ,    300},
    {14820,    "DJ mikseta"                    ,    350},
    {19920,    "Daljinski upravljac"           ,     80},
    {19808,    "Tastatura"                     ,     90}
};

enum E_VIDEO_OBJECT_DATA
{
    vidId,
    vidName[20],
    vidPrice
}
new const ObjectsVideo[][E_VIDEO_OBJECT_DATA] =
{
    {1782 ,    "iBox 65"            ,    300},
    {1783 ,    "Playhouse 4"        ,    250},
    {1785 ,    "Playhouse 3"        ,    200},
    {1787 ,    "Iomy CD player"     ,    250},
    {1788 ,    "Iomy sound recorder",    200},
    {1790 ,    "CD player"          ,    200},
    {19893,    "Otvoren laptop"     ,    400},
    {19894,    "Zatvoren laptop"    ,    400}
};

enum E_STEREO_OBJECT_DATA
{
    stId,
    stName[34],
    stPrice
}
new const ObjectsStereo[][E_STEREO_OBJECT_DATA] =
{
    {1840,    "Beli zvucnik"                     ,    250},
    {2229,    "Visoki crni zvucnik"              ,    350},
    {2230,    "Visoki zvucnik sa drvenom kutijom",    400},
    {2231,    "Niski zvucnik sa drvenom kutijom" ,    300},
    {2232,    "Niski crni zvucni"                ,    250},
    {2233,    "Moderni beli zvucnik"             ,    350}
};

enum E_RUG_OBJECT_DATA
{
    rId,
    rName[20],
    rPrice
}
new const ObjectsRugs[][E_RUG_OBJECT_DATA] =
{
    {1828,    "Tepih"        ,    200},
    {2815,    "Rozi tepih"   ,    300},
    {2817,    "Svetloplavi " ,    400},
    {2818,    "Crveni tepih" ,    430},
    {2833,    "Braon tepih"  ,    420},
    {2834,    "Krem tepih"   ,    480},
    {2835,    "Okrugli beli" ,    530},
    {2836,    "Beli tepih"   ,    425},
    {2841,    "Okrugli plavi",    425},
    {2842,    "Ljubicasti"   ,    490},
    {2847,    "Narandzasti"  ,    500}
};

enum E_FRIDGE_OBJECT_DATA
{
    frId,
    frName[22],
    frPrice
}
new const ObjectsFridge[][E_FRIDGE_OBJECT_DATA] =
{
    {2127 ,    "Dupli crveni frizider",    480},
    {2128 ,    "Crveni frizider"      ,    400},
    {2131 ,    "Siroki beli frizider" ,    500},
    {2140 ,    "Drveni frizider"      ,    465},
    {2141 ,    "Beli frizider"        ,    395},
    {2147 ,    "Sivi frizider"        ,    425},
    {2452 ,    "Zamrzivac"            ,    100},
    {19916,    "Stari frizider"       ,    123},
    {-2077,    "Frizider sa hranom"   ,    350}
};

enum E_KITCH_CABINETS_OBJECT_DATA
{
    kcId,
    kcName[37],
    kcPrice
}
new const ObjectsKitchenCabinets[][E_KITCH_CABINETS_OBJECT_DATA] =
{
    {2014 ,    "Zidni ormar i radni deo1"  ,    360},
    {2015 ,    "Zidni ormar i radni deo2"  ,    360},
    {11686,    "Drveni sank"               ,    500},
    {2016 ,    "Zidni ormar i radni deo3"  ,    360},
    {2022 ,    "Ugaoni radni deo i ormar"  ,    360},
    {2129 ,    "Crveni ormar i radni1"     ,    360},
    {2133 ,    "Beli radnio deo i fioke"   ,    400},
    {2134 ,    "Beli radnio deo i kredenac",    400},
    {2137 ,    "Drveni zidni ormar i radni",    400},
    {2139 ,    "Drveni radni"              ,    360},
    {2142 ,    "Drveni ormar"              ,    230},
    {2145 ,    "Visoki drveni ormar"       ,    300},
    {2156 ,    "Zeleni radni dio1"         ,    250},
    {2157 ,    "Zeleni radni dio2"         ,    250},
    {2158 ,    "Visoki drveni ormar"       ,    350},
    {2338 ,    "Ugaoni zeleni radni deo"   ,    300},
    {2341 ,    "Ugaoni beli radni deo"     ,    350},
    {19927,    "Sudoper"                   ,    260}
};

enum E_KITCH_DISHES_OBJECT_DATA
{
    dishId,
    dishName[18],
    dishPrice
}
new const ObjectsKitchenDishes[][E_KITCH_DISHES_OBJECT_DATA] =
{
    {11718,    "Lonac"           ,     50},
    {19584,    "Lonac2"          ,     50},
    {19585,    "Lonac3"          ,     50},
    {19581,    "Tava"            ,     70},
    {19583,    "Noz"             ,     30},
    {11715,    "Vilica"          ,     20},
    {11716,    "Noz"             ,     20},
    {19586,    "Spatula"         ,     50},
    {19809,    "Plato"           ,     20},
    {19830,    "Blender"         ,    100},
    {11743,    "Kafe aparat"     ,    120},
    {11744,    "Tanjur"          ,     20},
    {2865 ,    "Oprano sudje"    ,     60},
    {2850 ,    "Prljavo sudje1"  ,     50},
    {2832 ,    "Prljavo sudje2"  ,     50},
    {1455 ,    "Casa1"           ,     10},
    {1667 ,    "Casa vina"       ,     15},
    {19818,    "Prazna casa vina",     10},
    {19819,    "Casa koktel"     ,     10},
    {1666 ,    "Casa2"           ,     10},
    {1546 ,    "Casa3"           ,     10}
};

enum E_SINK_OBJECT_DATA
{
    snkId,
    snkName[41],
    snkPrice
}
new const ObjectsSink[][E_SINK_OBJECT_DATA] =
{
    {2013,    "Drveni ormar sa sudoperom"    ,    450},
    {2132,    "Beli ormar sa sudoperom"      ,    500},
    {2136,    "Drveni element sa sudoperom"  ,    550},
    {2160,    "Zeleni ormar sa sudoperom"    ,    350},
    {2336,    "Zeleni radni deo sa sudoperom",    350},
    {2515,    "Okrugla sudopera"             ,    200},
    {2518,    "Kockasta sudopera"            ,    285}
};

enum E_TABLES_OBJECT_DATA
{
    tablId,
    tablName[33],
    tablPrice
}
new const ObjectsTables[][E_TABLES_OBJECT_DATA] =
{
    {2126 ,    "Mali stol"                  ,    150},
    {2331 ,    "Mali stol2"                 ,    100},
    {2209 ,    "Kancelarijski stol"         ,    200},
    {2210 ,    "Staklena polica1"           ,    190},
    {2211 ,    "Staklena polica2"           ,    190},
    {2311 ,    "Siroki drveni stol"         ,    100},
    {2313 ,    "Televizor sa CD playerom"   ,     80},
    {2314 ,    "Sto za televizor"           ,    100},
    {2315 ,    "Drveni stol za televizor"   ,    100},
    {2319 ,    "Starinski stol za televizor",     90},
    {2346 ,    "Siroki kredenac"            ,     90},
    {2370 ,    "Niska polica"               ,     90},
    {2024 ,    "Stakleni stol"              ,    250},
    {19922,    "Siroki stol"                ,    200},
    {19997,    "Stol na rasklapanje"        ,    150},
    {1433 ,    "Mali drveni kockasti1"      ,    490},
    {1516 ,    "Mali drveni kockasti2"      ,    490},
    {1737 ,    "Moderni drveni"             ,    560},
    {1770 ,    "Stari beli"                 ,    350},
    {2029 ,    "Uski drveni"                ,    600},
    {2030 ,    "Mermerni okrugli"           ,    500},
    {2031 ,    "Drveni elipsasti"           ,    560},
    {2032 ,    "Crni drveni"                ,    560},
    {2080 ,    "Crni elipsasti"             ,    560},
    {2085 ,    "Stakleni"                   ,    600},
    {2086 ,    "Okrugli stakleni"           ,    600},
    {2109 ,    "Okrugli drveni stp"         ,    400},
    {2111 ,    "Niski okrugli drveni"       ,    490},
    {2112 ,    "Niski kockasti drveni"      ,    490},
    {2115 ,    "Kuhinjski drveni1"          ,    490},
    {2116 ,    "Kuhinjski drveni2"          ,    490},
    {2117 ,    "Kuhinjski drveni3"          ,    560},
    {2118 ,    "Mermerni"                   ,    520},
    {2357 ,    "Dugacki drveni"             ,    700},
    {2764 ,    "Pizzastack"                 ,    600},
    {2119 ,    "Medium za veceranje"        ,    520},
    {2110 ,    "Niski za veceranje"         ,    350},
    {1819 ,    "Coffeeic"                   ,    150},
    {1813 ,    "Coffeeic1"                  ,    150},
    {1814 ,    "Coffeeic2"                  ,    160},
    {1815 ,    "Coffeeic3"                  ,    160},
    {1816 ,    "Coffeeic4"                  ,    150},
    {1817 ,    "Coffeeic5"                  ,    150},
    {1818 ,    "Coffeeic6"                  ,    140},
    {1819 ,    "Coffeeic7"                  ,    140},
    {1820 ,    "Coffeeic8"                  ,    140},
    {1821 ,    "Coffeeic9"                  ,    140},
    {1822 ,    "Coffeeic10"                 ,    150},
    {1823 ,    "Coffeeic11"                 ,    160},
    {2081 ,    "Coffeeic12"                 ,    150},
    {2082 ,    "Coffeeic13"                 ,    160},
    {2083 ,    "Coffeeic14"                 ,    160},
    {2126 ,    "Coffeeic15"                 ,    150},
    {2236 ,    "Coffeeic16"                 ,    150}
};

enum E_CHAIRS_OBJECT_DATA
{
    chId,
    chName[30],
    chPrice
}
new const ObjectsChair[][E_CHAIRS_OBJECT_DATA] =
{
    {1720 ,    "Visoka bela"           ,    100},
    {1721 ,    "Uglasta"               ,     50},
    {1739 ,    "Visoka braon"          ,    200},
    {1810 ,    "Stolica na rasklapanje",     50},
    {1811 ,    "Niska drvena"          ,    200},
    {2079 ,    "Niska crna"            ,    170},
    {2120 ,    "Niska braon"           ,    170},
    {2121 ,    "Crvena na rasklapanje" ,     70},
    {2123 ,    "Bijela kozna"          ,    200},
    {2124 ,    "Bijela drvena"         ,    150},
    {2636 ,    "Moderna drvena"        ,    200},
    {2639 ,    "Pizzastack klupa"      ,    300},
    {2777 ,    "Stara crna"            ,    250},
    {2788 ,    "Pizzastack"            ,    135},
    {19994,    "Restoranska stolica"   ,    120},
    {19996,    "Stolica na rasklapanje",     70},
    {1805 ,    "Stolac"                ,     80}
};

enum E_STOVE_OBJECT_DATA
{
    stId,
    stName[33],
    stPrice
}
new const ObjectsStove[][E_STOVE_OBJECT_DATA] =
{
    {1733 ,    "Zastareli stednjak"     ,    150},
    {1777 ,    "Uski zastareli stednjak",    250},
    {2135 ,    "Moderni sa ormarom"     ,    550},
    {2144 ,    "Bijeli stednjak1"       ,    270},
    {2170 ,    "Bijeli stednjak2"       ,    250},
    {2294 ,    "Crveni sa ormarom"      ,    600},
    {2417 ,    "Siroki bijeli stednjak" ,    500},
    {2415 ,    "Stednjak za przenje"    ,    450},
    {19915,    "Stari stednjak"         ,    350},
    {19923,    "Stednjak"               ,    500},
    {19924,    "Napa"                   ,    600},
    {19933,    "Novi stednjak"          ,    550}
};

enum E_MICROWAVE_OBJECT_DATA
{
    mwId,
    mwName[25],
    mwPrice
}
new const ObjectsMicroWave[][E_MICROWAVE_OBJECT_DATA] =
{
    {2421,    "Moderna bela mikrovalna1",    150},
    {2149,    "Moderna bela mirkovalna2",    170}
};

enum E_TRASH_CAN_OBJECT_DATA
{
    tcId,
    tcName[29],
    tcPrice
}
new const ObjectsTrashCan[][E_TRASH_CAN_OBJECT_DATA] =
{
    {1235,    "Crna mrezna kanta"           ,    100},
    {1300,    "Gradska metalna kanta"       ,    150},
    {1328,    "Kucna metalna kanta"         ,    100},
    {1329,    "Bijela kanta"                ,     50},
    {1330,    "Siva kanta"                  ,     70},
    {1347,    "Ulicna crna kanta"           ,     60},
    {1359,    "Moderna mrezna kanta"        ,    150},
    {1371,    "Kanta u obliku nilskog konja",    190},
    {1549,    "Kanta za cigare"             ,     90}
};

enum E_TOILET_OBJECT_DATA
{
    toId,
    toName[30],
    toPrice
}
new const ObjectsToilet[][E_TOILET_OBJECT_DATA] =
{
    {2514 ,    "Bijela WC skoljka"      ,    190},
    {2521 ,    "Moderna bela WC skoljka",    250},
    {2525 ,    "Bijela WC skoljka"      ,    200},
    {2528 ,    "Braon-bela WC skoljka"  ,    270},
    {11707,    "Drzac za peskire"       ,    100},
    {2602 ,    "Lavabo"                 ,    300},
    {2739 ,    "Lavabo2"                ,    280},
    {19874,    "Sapun"                  ,     30},
    {19873,    "Toilet papir"           ,     10}
};

enum E_BATH_OBJECT_DATA
{
    baId,
    baName[29],
    baPrice
}
new const ObjectsBath[][E_BATH_OBJECT_DATA] =
{
    {2517 ,    "Uska kabina za tusiranje"    ,    350},
    {14481,    "Zastor za kadu"              ,    350},
    {2519 ,    "Bijela kada"                 ,    400},
    {2742 ,    "Fen za ruke"                 ,    300},
    {2520 ,    "Moderna kabina za tusiranje" ,    400},
    {2527 ,    "Otvorena kabina za tusiranje",    400},
    {2522 ,    "Moderna kada"                ,    500},
    {2526 ,    "Drvena kada"                 ,    450},
    {19809,    "Nova kada"                   ,    550}
};

enum E_MIRROR_OBJECT_DATA
{
    miId,
    miName[9],
    miPrice
}
new const ObjectsMirror[][E_MIRROR_OBJECT_DATA] =
{
    {14684,    "Ogledalo",    100}
};

enum E_BEDS_OBJECT_DATA
{
    bdId,
    bdName[41],
    bdPrice
}
new const ObjectsBed[][E_BEDS_OBJECT_DATA] =
{
    {1700 ,    "Bracni krevet sa roze posteljinom"       ,    300},
    {1701 ,    "Bracni krevet sa krem posteljinom"       ,    400},
    {1725 ,    "Bracni krevet sa smedjom posteljinom"    ,    400},
    {1745 ,    "Bracni krevet sa plavom posteljinom"     ,    100},
    {1771 ,    "Zatvorski krevet1"                       ,    100},
    {1794 ,    "Bracni krevet sa braon posteljinom"      ,    350},
    {1795 ,    "Swank bracni krevet"                     ,    360},
    {1796 ,    "Krevet sa braon posteljinom"             ,    100},
    {1797 ,    "Niski krevet bez posteljine"             ,    400},
    {1798 ,    "Niski krevet sa plavom posteljinom"      ,    450},
    {1799 ,    "Niski krevet sa braon posteljinom"       ,    450},
    {1802 ,    "Decji krevet sa roze posteljinom1"       ,    300},
    {1803 ,    "Decji krevet sa roze posteljinom2"       ,    400},
    {1812 ,    "Krevet na rasklapanje"                   ,    100},
    {2090 ,    "Krevet sa belom posteljinom"             ,    450},
    {2298 ,    "Bracni krevet sa dva kredenca"           ,    500},
    {2300 ,    "Bracni krevet sa velikim ormarom"        ,    500},
    {2301 ,    "Bracni krevet sa malim ormarom"          ,    450},
    {14446,    "Veliki bracni krevet"                    ,    600},
    {14866,    "Manji bracni krevet sa belom posteljinom",    500},
    {2566 ,    "Hotelski crni bracni krevet"             ,    550},
    {2575 ,    "Hotelski smedji krevet"                  ,    500}
};

enum E_NIGHTSTAND_OBJECT_DATA
{
    nsId,
    nsName[32],
    nsPrice
}
new const ObjectsNightStand[][E_NIGHTSTAND_OBJECT_DATA] =
{
    {1740,    "Otvoreni drveni kredenac"       ,    100},
    {2095,    "Zatvoreni drveni kredenac"      ,    100},
    {2328,    "Zatvoreni niski drveni kredenac",    100}
};

enum E_CHEST_OBJECT_DATA
{
    cId,
    cName[29],
    cPrice
}
new const ObjectsChest[][E_CHEST_OBJECT_DATA] =
{
    {1417,    "Zatvoreni drveni ormar"      ,    450},
    {1741,    "Niski zatvoreni drveni"      ,    150},
    {1743,    "Niski ormar sa fiokama"      ,    200},
    {2088,    "Zatvoreni drveni ormar"      ,    400},
    {2089,    "Niski crni ormar sa fiokama" ,    300},
    {2307,    "Ormar sa fiokama i policama1",    150},
    {2329,    "Ormar sa fiokama i policama2",    150}
};

enum E_CLOTHES_OBJECT_DATA
{
    cloId,
    cloName[29],
    cloPrice
}
new const ObjectsClothes[][E_CLOTHES_OBJECT_DATA] =
{
    {2390 ,    "Donji delovi zelene trenerke",    50},
    {2391 ,    "Niz odece1"                  ,    60},
    {2394 ,    "Niz odece2"                  ,    60},
    {2396 ,    "Gornji delovi crne trenerke" ,    50},
    {2397 ,    "Bele farmerke"               ,    60},
    {2398 ,    "Donji delovi plave trenerke" ,    50},
    {2399 ,    "Beli duksevi"                ,    60},
    {2401 ,    "Donji delovi crne trenerke"  ,    50},
    {2819 ,    "Razbacana odeca1"            ,    70},
    {2843 ,    "Razbacana odeca2"            ,    70},
    {2844 ,    "Razbacana odeca3"            ,    70},
    {2845 ,    "Razbacana odeca4"            ,    70},
    {2846 ,    "Razbacana odeca5"            ,    70},
    {19921,    "Kofer"                       ,    60}
};

enum E_PLANTS_OBJECT_DATA
{
    plntId,
    plntName[38],
    plntPrice
}
new const ObjectsPlants[][E_PLANTS_OBJECT_DATA] =
{
    {638  ,    "Zbunasta biljka u dugackoj vazi"      ,    150},
    {948  ,    "Cvece u modernoj beloj vazi"          ,     50},
    {949  ,    "Cvece u staroj sivoj vazi"            ,     40},
    {950  ,    "Cvece u sirokoj staroj sivoj vazi"    ,     60},
    {2001 ,    "Palma u rozoj vazi1"                  ,     60},
    {1361 ,    "Zbunasta biljka u betonskoj vazi"     ,    250},
    {2010 ,    "Palma u rozoj vazi2"                  ,     60},
    {2011 ,    "Palma u sivoj vazi"                   ,     60},
    {2194 ,    "Niska biljka u narandzastoj vazi1"    ,     50},
    {2195 ,    "Niska biljka u narandzastoj vazi2"    ,     60},
    {2240 ,    "Niska biljka u loptastoj crvenoj vazi",     80},
    {2241 ,    "Niska biljka u narandzastoj vazi3"    ,     60},
    {2244 ,    "Niska biljka u kockastoj drvenoj vazi",     60},
    {2245 ,    "Niska biljka u narandzastoj vazi4"    ,     60},
    {2811 ,    "Cvece u keramickoj vazi"              ,     70},
    {2247 ,    "Cvece u staklenoj vazi1"              ,     40},
    {2249 ,    "Cvece u staklenoj vazi2"              ,     40},
    {2250 ,    "Cvece u staklenoj vazi3"              ,     40},
    {2251 ,    "Cvece u plavoj vazi"                  ,     40},
    {2252 ,    "Zuta vaza"                            ,     40},
    {2253 ,    "Nisko cvece u kockastoj zutoj vazi"   ,     40},
    {2345 ,    "Cvece sa ograde"                      ,     60},
    {14804,    "Niska palma u modernoj vazi"          ,    100},
    {-2079,    "Biljka marihuane"                     ,    200}
};

enum E_PAINTINGS_OBJECT_DATA
{
    pntId,
    pntName[30],
    pntPrice
}
new const ObjectsPaint[][E_PAINTINGS_OBJECT_DATA] =
{
    {1736,    "Jelenova glava za zid"     ,    600},
    {2254,    "Zidna slika1"              ,    200},
    {2255,    "Zidna slika2"              ,    250},
    {2256,    "Zidna slika3"              ,    350},
    {2257,    "Zidna slika4"              ,    370},
    {2258,    "Zidna slika5"              ,    200},
    {2259,    "Zidna slika6"              ,    200},
    {2260,    "Uska zidna slika1"         ,    150},
    {2261,    "Uska zidna slika2"         ,    150},
    {2262,    "Uska zidna slika3"         ,    100},
    {2263,    "Uska zidna slika4"         ,    120},
    {2264,    "Uska zidna slika5"         ,    130},
    {2265,    "Uska zidna slika6"         ,    100},
    {2266,    "Slika sa drvenim okvirom1" ,    125},
    {2267,    "Slika sa drvenim okvirom2" ,    147},
    {2268,    "Slika sa drvenim okvirom3" ,    158},
    {2269,    "Slika sa drvenim okvirom4" ,    147},
    {2270,    "Slika sa drvenim okvirom5" ,    100},
    {2271,    "Slika sa drvenim okvirom6" ,    100},
    {2272,    "Slika sa belim okvirom1"   ,     50},
    {2273,    "Slika sa belim okvirom2"   ,     50},
    {2274,    "Slika sa belim okvirom3"   ,     50},
    {2275,    "Slika sa belim okvirom4"   ,     50},
    {2276,    "Slika sa belim okvirom5"   ,     50},
    {2277,    "Slika sa belim okvirom6"   ,     50},
    {2278,    "Slika sa debelim okvirom1" ,     50},
    {2279,    "Slika sa debelim okvirom2" ,     50},
    {2280,    "Slika sa debelim okvirom3" ,     50},
    {2281,    "Slika sa debelim okvirom4" ,     50},
    {2282,    "Slika sa debelim okvirom5" ,     50},
    {2283,    "Slika sa debelim okvirom6" ,     50},
    {2284,    "Slika sa ukrasnim okvirom1",     70},
    {2285,    "Slika sa ukrasnim okvirom2",     70},
    {2587,    "Porn poster1"              ,     50},
    {2588,    "Porn poster2"              ,     50},
    {2828,    "Slika para"                ,     36},
    {9189,    "Big fat dude"              ,     80}
};

enum E_FUN_OBJECT_DATA
{
    fnId,
    fnName[30],
    fnPrice
}
new const ObjectsFun[][E_FUN_OBJECT_DATA] =
{
    {1598 ,    "Lopta za plazu"            ,     100},
    {1742 ,    "Velika polica za knjige"   ,     400},
    {2779 ,    "Aparat za kockanje"        ,     800},
    {1946 ,    "Kosarkaska lopta"          ,     100},
    {-2080,    "Studio mikrofon"           ,     400},
    {2190 ,    "Kompjuter #1"              ,     350},
    {-2043,    "Kompjuter #2"              ,     350},
    {-2037,    "Laptop"                    ,     600},
    {-2059,    "iPad"                      ,     500},
    {-2033,    "Karte"                     ,      10},
    {2188 ,    "Blackjack stol"            ,    1000},
    {955  ,    "Sprunk aparat"             ,     500},
    {2824 ,    "Razbacane knjige1"         ,      50},
    {2825 ,    "Razbacane knjige2"         ,      50},
    {2826 ,    "Razbacane knjige3"         ,      50},
    {2827 ,    "Razbacane knjige4"         ,      50},
    {2852 ,    "Razbacani stripovi1"       ,      50},
    {2853 ,    "Razbacani stripovi2"       ,      50},
    {2854 ,    "Razbacani stripovi3"       ,      50},
    {2855 ,    "Razbacani stripovi4"       ,      50},
    {2872 ,    "Gaming automat"            ,    1500},
    {2894 ,    "Otvorena knjiga"           ,      70},
    {14455,    "Velika polica za knjige"   ,     550},
    {1600 ,    "Riba"                      ,     100},
    {1601 ,    "Ribice"                    ,     100},
    {2404 ,    "Daska za surfanje1"        ,     200},
    {2405 ,    "Daska za surfanje2"        ,     200},
    {2406 ,    "Daska za surfanje3"        ,     200},
    {1641 ,    "Rucnik za plazu"           ,     100},
    {1642 ,    "Rucnik za plazu(crveni)"   ,     100},
    {1643 ,    "Rucnik za plazu(zuti)"     ,     100},
    {2689 ,    "Vjesalica sa tutom"        ,     200},
    {2689 ,    "Vjesalica sa tutom(orange)",     250},
    {1793 ,    "Stari madrac"              ,     500},
    {2767 ,    "Drvena plata za jelo"      ,     200},
    {2768 ,    "Burger"                    ,     100},
    {2769 ,    "Burger 2"                  ,     250},
    {2857 ,    "Karton od pizze"           ,     150},
    {2858 ,    "Kineska hrana"             ,     100},
    {2814 ,    "Karton pizze"              ,     100},
    {2821 ,    "Kutija pahuljica"          ,     100},
    {2860 ,    "Kutija pizze sa komadima"  ,     120},
    {2856 ,    "Mlijeko"                   ,     100},
    {2867 ,    "Mlijeko i zitarice"        ,     150},
    {2880 ,    "Burger"                    ,     120},
    {2034 ,    "Stara sacmarica"           ,     120},
    {2035 ,    "M4"                        ,     120},
    {2485 ,    "Autic"                     ,     300},
    {2486 ,    "Makete Aviona"             ,     300},
    {1210 ,    "Kovceg"                    ,     200},
    {-2054,    "Novcanica"                 ,      10},
    {-2065,    "Manji motuljak novaca"     ,     100},
    {-2066,    "Smotuljak novaca"          ,     200},
    {1212 ,    "Novac"                     ,     300},
    {2881 ,    "Pizza"                     ,     320},
    {2037 ,    "Kutija"                    ,     120},
    {2812 ,    "Prljavo sudje"             ,      80},
    {2673 ,    "Razbacan Sprunk"           ,     100},
    {2674 ,    "Cigare i papir"            ,     120},
    {-2047,    "Cigarete #1"               ,      50},
    {-2048,    "Cigarete #2"               ,      50},
    {2675 ,    "Razbacani burgeri"         ,     125},
    {2676 ,    "Razbacani burgeri #2"      ,     130},
    {2677 ,    "Razbacani burgeri #3"      ,     150},
    {-2034,    "Burger bag"                ,       5},
    {2670 ,    "Cigarete i papiri"         ,     120},
    {19617,    "GoldRecord1"               ,     100},
    {19609,    "Bubnjevi"                  ,     500},
    {19612,    "Guitar amp #1"             ,     250},
    {19613,    "Guitar amp #2"             ,     250},
    {19614,    "Guitar amp #3"             ,     250},
    {19615,    "Guitar amp #4"             ,     250},
    {19616,    "Guitar amp #5"             ,     250},
    {1957 ,    "Mixing console"            ,     200},
    {19317,    "Gitara"                    ,     300},
    {-2136,    "iMac"                      ,     300},
    {-2146,    "Aktovka sa novcima"        ,     400},
    {1255 ,    "Wooden cot"                ,     200}
};

enum E_LIGHTS_OBJECT_DATA
{
    lgtId,
    lgtName[32],
    lgtPrice
}
new const ObjectsLights[][E_LIGHTS_OBJECT_DATA] =
{
    {921  ,    "Zidno svjetlo"            ,    200},
    {940  ,    "Plafnoska svjetla"        ,    200},
    {1731 ,    "Malo zidno svjetlo"       ,    200},
    {1734 ,    "Malo zidno svjetlo2"      ,    200},
    {1893 ,    "Plafonsko neonsko svjetlo",    400},
    {2026 ,    "Plafonsko bijelo svjetlo" ,    150},
    {2069 ,    "Visoka podna svjetiljka"  ,    150},
    {2073 ,    "Zuta plafonska svjetla"   ,    200},
    {2107 ,    "Stolna sobna lampa"       ,    180},
    {2106 ,    "Stolna sobna lampa1"      ,    180},
    {2105 ,    "Stolna sobna lampa2"      ,    180},
    {2108 ,    "Bijela plafonska svjetla" ,    150},
    {2239 ,    "Visoka podna svjetiljka"  ,    150},
    {2726 ,    "Strip lamp"               ,    135},
    {2238 ,    "Lava lamp"                ,    125},
    {2196 ,    "Uredska lampa"            ,     55},
    {2179 ,    "Casino light"             ,    125},
    {2076 ,    "Plafonsko svjetlo"        ,     90},
    {2074 ,    "Plafonsko svjetlo"        ,    100},
    {2072 ,    "Sobno svjetlo"            ,    110},
    {2071 ,    "Sobno svjetlo1"           ,    110},
    {2070 ,    "Sobno svjetlo2"           ,     58},
    {16780,    "UFO Light"                ,    500},
    {19806,    "Barokni luster"           ,    450},
    {19154,    "Party lamp"               ,    250},
    {2176 ,    "Casino light2"            ,   1000}
};

enum E_DRINKS_OBJECT_DATA
{
    drnksId,
    drnksName[30],
    drnksPrice
}
new const ObjectsDrinks[][E_DRINKS_OBJECT_DATA] =
{
    {1486 ,    "Corona"             ,     50},
    {1512 ,    "Don Perignon wine"  ,     70},
    {1520 ,    "Jack Daniels"       ,    150},
    {1543 ,    "Budlight strawberry",     50},
    {1544 ,    "Budlight lime"      ,     50},
    {1546 ,    "Sprunk"             ,     40},
    {1667 ,    "Wine glass"         ,     60},
    {1545 ,    "B_OPTIC1"           ,     50},
    {1668 ,    "Atlantic vodka"     ,     80},
    {1669 ,    "Imperia vodka"      ,    100},
    {1670 ,    "Drinking set"       ,    200},
    {1209 ,    "Automat za sokove"  ,    700},
    {-2114,    "Pivo 1"             ,     50},
    {-2115,    "Pivo 2"             ,     50},
    {-2116,    "Pivo 3"             ,     50},
    {-2117,    "Pivo 4"             ,     50},
    {-2118,    "Gajba Piva 1"       ,     50},
    {-2119,    "Gajba Piva 2"       ,     50},
    {-2120,    "Gajba Piva 3"       ,     50},
    {-2121,    "Gajba Piva 4"       ,     50},
    {-2122,    "Flasa soka 1"       ,     50},
    {-2123,    "Flasa soka 2"       ,     50},
    {-2124,    "Limenka soka 1"     ,     50},
    {-2125,    "Limenka soka 2"     ,     50},
    {-2126,    "Flasa Vodke 1"      ,     50},
    {-2127,    "Flasa Vodke 2"      ,     50},
    {-2128,    "Flasa Ruma"         ,     50},
    {-2129,    "Sampanjac"          ,     50},
    {-2130,    "New English pivo"   ,     50},
    {-2131,    "Pivo iz marketa"    ,     50},
    {-2132,    "Krigla piva"        ,     50},
    {-2133,    "Limunada"           ,     50},
    {-2134,    "Casa vina 1"        ,     50},
    {-2135,    "Casa vina 2"        ,     50}
};

enum E_DOOR_OBJECTS_DATA
{
    doorId,
    doorName[24],
    doorPrice,
    bool:doorCanMove
}

new const ObjectsDoor[][E_DOOR_OBJECTS_DATA] =
{
    {3093 ,    "Bijela drvena"          ,     80 ,    true },
    {3089 ,    "Drvena uredska"         ,     150,    true },
    {2959 ,    "Crvena velika"          ,     300,    true },
    {2970 ,    "Plava apartmanska"      ,     450,    true },
    {2924 ,    "Svijetlo plava zeljezna",     210,    true },
    {2949 ,    "Industrijska siva"      ,     196,    true },
    {2948 ,    "Siva izlozna"           ,     225,    true },
    {2911 ,    "Bijela drvena"          ,     136,    true },
    {977  ,    "Drvena s prozorom"      ,     425,    true },
    {1491 ,    "Drvena s urezima"       ,     200,    false},
    {1523 ,    "Bela sa prozorcicem"    ,     160,    false},
    {1492 ,    "Zelena drvena"          ,     225,    false},
    {1493 ,    "Crvena s mrezom"        ,     260,    true },
    {1494 ,    "Tamno plava drvena"     ,     125,    false},
    {1495 ,    "Siva s zastitom"        ,     90 ,    true },
    {1496 ,    "Siva s prozorom"        ,     115,    true },
    {1497 ,    "Siva drvena"            ,     85 ,    true },
    {1498 ,    "Bijela ulazna"          ,     135,    true },
    {1499 ,    "Industrijska"           ,     115,    false},
    {1500 ,    "Industrijska #2"        ,     120,    true },
    {1501 ,    "Smedja drvena"          ,     125,    true },
    {1502 ,    "Sobna drvena"           ,     185,    false},
    {1506 ,    "Ulazna bijela"          ,     225,    true },
    {1535 ,    "Apartmanska"            ,     185,    true },
    {1536 ,    "Luksuzna crna"          ,     425,    true },
    {1555 ,    "Ljubicasta vrata"       ,     115,    true },
    {1556 ,    "Luksuzna izlozna"       ,     268,    true },
    {1566 ,    "Ulazna s prozorom"      ,     358,    true },
    {1567 ,    "Bijela sobna"           ,     156,    true },
    {1569 ,    "Luksuzna apartmanska"   ,     436,    true },
    {13360,    "Stara drvena"           ,     56 ,    true },
    {19302,    "Zatvorska vrata"        ,     500,    true }
};

enum E_WALL_OBJECT_DATA
{
    wlId,
    wlName[18],
    wlPrice
}
new const ObjectsWalls[][E_WALL_OBJECT_DATA] =
{
    {19430,    "Mali zid 2x4"   ,     600},
    {19355,    "Srednji zid 4x4",     950},
    {19449,    "Veliki zid 8x4" ,    1000},
    {19387,    "Zid za vrata"   ,     650},
    {19403,    "Zid za prozor"  ,     625},
    {19379,    "Pod 10x10"      ,    1150}
};

enum E_FOOD_OBJECTS_DATA
{
    foodId,
    foodName[34],
    foodPrice
}
new const ObjectsFood[][E_FOOD_OBJECTS_DATA] =
{
    {2703 ,    "Hamburger"     ,     20},
    {2768 ,    "Cluckin' meal" ,     20},
    {2769 ,    "Burg Wrap"     ,     22},
    {2804 ,    "Meat1"         ,     50},
    {19560,    "Meat2"         ,     20},
    {19582,    "Steak"         ,     50},
    {2814 ,    "Pizza Kutija"  ,      5},
    {19580,    "Pizza"         ,     25},
    {2858 ,    "Kineska hrana" ,     21},
    {2866 ,    "Ostaci hrane"  ,     18},
    {11722,    "Kecap"         ,     10},
    {11723,    "Senf"          ,     10},
    {19563,    "Sok1"          ,     10},
    {19564,    "Sok2"          ,     10},
    {19567,    "Sladoled"      ,     15},
    {19568,    "Sladoled2"     ,     15},
    {19569,    "Mlijeko Karton",      5},
    {19570,    "Mlijeko Boca"  ,      7},
    {19847,    "Sunka"         ,     50},
    {19883,    "Tost"          ,      3},
    {19574,    "Naranca"       ,      2},
    {19575,    "Jabuka1"       ,      2},
    {19576,    "Jabuka2"       ,      2},
    {19577,    "Paradajz"      ,      5},
    {19578,    "Banana"        ,      6},
    {19525,    "Torta1"        ,    100},
    {11739,    "Torta2"        ,    102},
    {11740,    "Torta3"        ,    103},
    {11741,    "Torta4"        ,    105}
};

enum E_SPORTS_OBJECT_DATA
{
    gmId,
    gmName[30],
    gmPrice
}
new const ObjectsSports[][E_SPORTS_OBJECT_DATA] =
{
    {1985,    "Vreca za udaranje"         ,     450},
    {2627,    "Traka za trcanje"          ,     700},
    {2628,    "Bench1"                    ,     750},
    {2629,    "Bench2"                    ,     800},
    {2630,    "Bicikl"                    ,     900},
    {2913,    "Bench sipka"               ,     500},
    {2915,    "Two dumbbells"             ,     800},
    {2916,    "One dumbbell"              ,     750},
    {2631,    "Ruzicasta podloga"         ,      50},
    {2632,    "Plava podloga"             ,      50},
    {2964,    "Stol za bilijar"           ,    1300},
    {3122,    "Stap za bilijar"           ,      30},
    {3003,    "Bijela kugla"              ,      20},
    {3100,    "Plava (cijela) kugla"      ,      20},
    {3101,    "Crvena (cijela) kugla"     ,      20},
    {3102,    "Ljubicasta (cijela) kugla" ,      20},
    {3103,    "Narandzasta (cijela) kugla",      20},
    {3104,    "Zelena (cijela) kugla"     ,      20},
    {3105,    "Bordo (cijela) kugla"      ,      20},
    {3106,    "Crna (osmica) kugla"       ,      20},
    {2995,    "Zuta (pola) kugla"         ,      20},
    {2996,    "Plava (pola) kugla"        ,      20},
    {2997,    "Crvena (pola) kugla"       ,      20},
    {2998,    "Ljubicasta (pola) kugla"   ,      20},
    {2999,    "Narandzasta (pola) kugla"  ,      20},
    {3000,    "Zelena (pola) kugla"       ,      20},
    {3001,    "Bordo (pola) kugla"        ,      20},
    {2965,    "Trokut"                    ,      20},
    {1598,    "Lopta za plazu"            ,      25},
    {1946,    "Lopta za kosarku"          ,      25},
    {1974,    "Loptica za golf"           ,      15},
    {333 ,    "Stap za golf"              ,      30},
    {3128,    "Mreza za kosarku"          ,     125},
    {3497,    "Kos"                       ,     300}
};

enum E_HEATER_OBJECT_DATA
{
    htrId,
    htrName[30],
    htrPrice
}
new const ObjectsHeater[][E_HEATER_OBJECT_DATA] =
{
    {1738,    "Radijator"      ,    700},
    {1971,    "Plava grijalica",    650}
};

enum E_MISC_OBJECT_DATA
{
    etcId,
    etcName[30],
    etcPrice
}
new const ObjectsRest[][E_MISC_OBJECT_DATA] =
{
    {-2078,    "Kutija sa Jordanicama"  ,     150},
    {1428 ,    "Male ljestve"           ,      50},
    {1485 ,    "Joint"                  ,      20},
    {3027 ,    "Cigara"                 ,      40},
    {-2041,    "Shisha"                 ,     200},
    {1510 ,    "Pepeljara #1"           ,      50},
    {19993,    "Pepeljara #2"           ,      50},
    {-2039,    "Pepeljara #3"           ,      50},
    {1665 ,    "Velika pepeljara"       ,      70},
    {2616 ,    "Policijska ploca"       ,     125},
    {2051 ,    "CJ meta"                ,      25},
    {2711 ,    "Tatoo masinica"         ,      85},
    {2680 ,    "Kljucanica"             ,      20},
    {14693,    "Tatoo stol"             ,     500},
    {14693,    "Tatoo stol"             ,     500},
    {19273,    "KeypadNonDynamic"       ,     200},
    {929  ,    "Generator"              ,     300},
    {1481 ,    "Rostilj"                ,     550},
    {1208 ,    "Perilica rublja"        ,     800},
    {1661 ,    "Plafonski ventilator"   ,    1000},
    {1808 ,    "Water cooler"           ,     100},
    {2332 ,    "High lock sef"          ,    1250},
    {-2040,    "Sef(guns&money)"        ,    1000},
    {2868 ,    "Organic svijeca"        ,      35},
    {2869 ,    "Svijece za veceru"      ,      30},
    {2870 ,    "Velike svijece"         ,      40},
    {14705,    "Vaza"                   ,      35},
    {1961 ,    "Diskografska ploca"     ,      95},
    {1960 ,    "Diskografska ploca1"    ,      95},
    {1962 ,    "Diskografska ploca2"    ,      95},
    {19914,    "Palica"                 ,      30},
    {19919,    "Stalak"                 ,      90},
    {28659,    "Grafit Grove"           ,     100},
    {18661,    "Grafit Varrio"          ,     100},
    {18664,    "Grafit Ballas"          ,     100},
    {18665,    "Grafit Vagos"           ,     100},
    {18660,    "Grafit Seville"         ,     100},
    {19586,    "Hvataljka"              ,     110},
    {19584,    "Posude"                 ,     100},
    {-2042,    "Vaga"                   ,     100},
    {-2053,    "Digitalna vagica"       ,     200},
    {19583,    "Noz"                    ,     100},
    {-2067,    "Zilet"                  ,      50},
    {-2070,    "Zlica"                  ,      50},
    {-2072,    "Bijeli prah"            ,      50},
    {19575,    "Jabuka"                 ,     100},
    {19576,    "Jabuka Z"               ,     150},
    {19472,    "Maska"                  ,     110},
    {19603,    "Voda"                   ,     120},
    {19618,    "Sef"                    ,     500},
    {19164,    "GTA Mapa #1"            ,     800},
    {19165,    "GTA Mapa #2"            ,     700},
    {19166,    "GTA Mapa #3"            ,     825},
    {19167,    "GTA Mapa #4"            ,     650},
    {19168,    "GTA Mapa #5 (dio 1)"    ,     900},
    {19169,    "GTA Mapa #6 (dio 2)"    ,     900},
    {19170,    "GTA Mapa #6 (dio 3)"    ,     900},
    {19171,    "GTA Mapa #6 (dio 4)"    ,     900},
    {19632,    "Drva za ogrjev"         ,     500},
    {-2030,    "Zatvorena aktovka"      ,      70},
    {-2031,    "Otvorena aktovka"       ,      70},
    {-2032,    "Koverta"                ,       5},
    {-2035,    "Kutija s pistoljima"    ,     100},
    {-2036,    "Kutija s puskama"       ,     150},
    {-2076,    "Truplo"                 ,     100},
    {-2068,    "Tablete"                ,     100},
    {-2044,    "Baking Soda"            ,      50},
    {-2069,    "Soda bikarbona i kokain",     100},
    {-2045,    "Kesa kokaina"           ,      50},
    {-2049,    "Gruda kokaina"          ,     100},
    {-2060,    "Linija bijelog"         ,      50},
    {-2046,    "Kesa marihuane"         ,      50},
    {-2075,    "Tuba za smrkanje"       ,      50},
    {-2061,    "Cvijetovi marihuane"    ,      50},
    {-2061,    "Crystal meth pipe"      ,      50},
    {-2073,    "Patent kesica s prahom" ,      50},
    {-2074,    "Patent kesica s methom" ,      50},
    {-2051,    "Kesa cracka"            ,      50},
    {-2056,    "Kesa extasya"           ,      50},
    {-2071,    "Inekcija"               ,      50},
    {-2058,    "Zlica sa heroinom"      ,     100},
    {1575 ,    "Paket droge"            ,     350},
    {-2055,    "Droga u foliji"         ,      50},
    {-2057,    "Prazna kesica"          ,      20},
    {-2038,    "Meci u kutiji"          ,     120},
    {-2063,    "Brojac novaca #1"       ,     300},
    {-2064,    "Brojac novaca #2"       ,     300},
    {-2050,    "BIC upaljac"            ,      50},
    {-2052,    "Kreditna kartica"       ,      30}
};

enum E_CURTAINS_OBJECT_DATA
{
    crtId,
    crtName[15],
    crtPrice
}
new const ObjectsCurtains[][E_CURTAINS_OBJECT_DATA] =
{
    {2558 ,    "Male zavjese"  ,     85},
    {2560 ,    "Siroke zavjese",    125},
    {2561 ,    "Velike zavjese",    115},
    {16732,    "Roletne"       ,    200}
};

enum E_ANIMALS_OBJECT_DATA
{
    amId,
    amName[34],
    amPrice
}
new const ObjectsAnimals[][E_ANIMALS_OBJECT_DATA] =
{
    {1599 ,    "Zuta riba"    ,     150},
    {1600 ,    "Plava riba"   ,     100},
    {1601 ,    "Plave ribe"   ,     300},
    {1605 ,    "Zute ribe"    ,     300},
    {1606 ,    "Plave ribe"   ,     200},
    {19630,    "Riba"         ,     200},
    {1602 ,    "Bijela meduza",     200},
    {1603 ,    "Meduza"       ,     200},
    {19315,    "Jelen"        ,    1500},
    {1607 ,    "Dupin"        ,    2000},
    {1608 ,    "Morski pas"   ,    2500},
    {1609 ,    "Kornjaca"     ,    3000},
    {19078,    "Papiga"       ,    3000}
};

enum E_WINDOWS_OBJECT_DATA
{
    wnId,
    wnName[34],
    wnPrice
}
new const ObjectsWindows[][E_WINDOWS_OBJECT_DATA] =
{
    {19466,    "Malo staklo"   ,    200},
    {19325,    "Veliko staklo" ,    500},
    {1651 ,    "Srednje staklo",    350}
};


enum E_OFFICE_OBJECTS_DATA
{
    ofId,
    ofName[34],
    ofPrice
}
new const ObjectsOffice[][E_OFFICE_OBJECTS_DATA] =
{
    {1806 ,    "Plava stolica"   ,     150},
    {1998 ,    "Stol1"           ,     800},
    {1999 ,    "Stol2"           ,     500},
    {2008 ,    "Stol3"           ,     700},
    {2009 ,    "Stol4"           ,     900},
    {2202 ,    "Stampac"         ,     500},
    {2161 ,    "Kif kuf police"  ,     150},
    {2309 ,    "Stolac"          ,     100},
    {9362 ,    "Cijeli ured"     ,    3000},
    {16378,    "Cijeli ured1"    ,    2500},
    {11631,    "Ranch stol"      ,    1500},
    {2172 ,    "OFFICE2_DESK"    ,    1500},
    {19825,    "Sat"             ,     600},
    {2007 ,    "Uredski ormarici",     600},
    {19999,    "Moderna stolica" ,     300}
};

enum E_FM_OBJECTS_DATA
{
    fmId,
    fmName[34],
    fmPrice
}
new const FurnitureM[][E_FM_OBJECTS_DATA] =
{
    {18260,    "Velike kutije"     ,     800},
    {19087,    "Kanap"             ,    1000},
    {1895 ,    "Casino"            ,    1300},
    {1978 ,    "Casino stol"       ,     700},
    {2343 ,    "BARB_CHAIR"        ,     400},
    {2986 ,    "Ventilacija"       ,     100},
    {13817,    "Garazna vrata"     ,     700},
    {1826 ,    "Stol za casino x2" ,     900},
    {1085 ,    "Guma"              ,      50},
    {1896 ,    "Stol za casino x3" ,    1000},
    {2166 ,    "Kutni stol"        ,     700},
    {8572 ,    "Stepenice"         ,    3000},
    {7073 ,    "Covjek"            ,    2500},
    {19172,    "Slika1"            ,     600},
    {19173,    "Slika2"            ,     600},
    {19174,    "Slika3"            ,     600},
    {19175,    "Slika4"            ,     600},
    {1833 ,    "Slot1"             ,     600},
    {1835 ,    "Slot2"             ,     600},
    {1836 ,    "Vise slotova"      ,     600},
    {14607,    "Ulaz u casino"     ,     600},
    {18740,    "Voda1"             ,     600},
    {18720,    "Voda2"             ,     600},
    {18744,    "Vode3"             ,     600},
    {18742,    "Voda4"             ,     600},
    {18743,    "Vode5"             ,     600},
    {18648,    "Blue Neon"         ,     600},
    {18649,    "Green Neon"        ,     600},
    {18651,    "Purple Neon"       ,     600},
    {18647,    "Red Neon"          ,     600},
    {18650,    "Yellow Neon"       ,     600},
    {18658,    "Blue Reflector"    ,     900},
    {18657,    "Red Reflector"     ,     900},
    {19610,    "Mikrofon"          ,     900},
    {19611,    "Stalak za mikrofon",     900},
    {2491 ,    "Stalak za odjecu"  ,     900},
    {2614 ,    "SAD Flag"          ,     900},
    {2606 ,    "Few TVs"           ,    2000},
    {1715 ,    "Uredska stolica"   ,    1000},
    {1886 ,    "Canon 500D"        ,    1000},
    {1759 ,    "Fotelja"           ,    1000},
    {2184 ,    "Office Desk"       ,    2000},
    {1714 ,    "Kozna fotelja"     ,    1000},
    {2773 ,    "Fancy ograda"      ,    1000},
    {11245,    "US Flag"           ,    1000},
    {11724,    "Kamin"             ,    1000}
};


enum E_BAR_DRINKS_OBJECTS_DATA
{
    bardId,
    bardName[20],
    bardPrice
}
new const ObjectsBarDrinks[][E_BAR_DRINKS_OBJECTS_DATA] =
{
    {1486  ,    "Corona pivo"            , 60  },
    {1512  ,    "Don Perignon wine"      , 70  },
    {1520  ,    "Jack Daniels"           , 150 },
    {1543  ,    "Budlight strawberry"    , 60  },
    {1544  ,    "Budlight lime"          , 60  },
    {1546  ,    "Sprunk"                 , 50  },
    {1667  ,    "Wine glass"             , 80  },
    {1668  ,    "Atlantic vodka"         , 100 },
    {1669  ,    "Imperia vodka"          , 120 },
    {1670  ,    "Drinking set"           , 220 },
    {1209  ,    "Automat za sokove"      , 1000},
    {1541  ,    "Tocionik piva"          , 800 },
    {2425  ,    "Tocionik Sprunka"       , 700 },
    {2427  ,    "Tocionik Sprunka"       , 750 },
    {11686 ,    "Sank i tocionici"       , 1500},
    {-2114 ,    "Coa beerbottles1"       , 150 },
    {-2115 ,    "Coa beerbottles2"       , 100 },
    {-2116 ,    "Coa beerbottles3"       , 200 },
    {-2117 ,    "Coa beerbottles4"       , 125 },
    {-2118 ,    "Coa beerbottles5"       ,  80 },
    {-2119 ,    "Coa beerbottles6"       , 250 },
    {-2120 ,    "Coa beerbottles7"       , 100 },
    {-2121 ,    "Coa beerbottles8"       , 500 }
};

enum E_247_FRIDGES_OBJECTS_DATA
{
    sfrId,
    sfrName[20],
    sfrPrice
}
new const Objects247Fridge[][E_247_FRIDGES_OBJECTS_DATA] =
{
    { 1842     , "Podni"              , 3000},
    { 1843     , "Zidni1"             , 3000},
    { 1844     , "Zidni2"             , 3000},
    { 1845     , "Prolaz"             , 3000},
    { 1847     , "Zidni3"             , 3000},
    { 1848     , "Zidni4"             , 3000},
    { 1849     , "Prazan zidni"       , 2500},
    { 1850     , "Prazan zidni1"      , 2000},
    { 1884     , "Zidni5"             , 3000},
    { 1887     , "Zidni6"             , 3000},
    { 1888     , "Zidni7"             , 3000},
    { 1889     , "Zidni8"             , 3000},
    { 1890     , "Zidni9"             , 3100},
    { 1891     , "Zidni10"            , 3100},
    { 1981     , "Modularn1"          , 800 },
    { 1982     , "Modularn2"          , 850 },
    { 1983     , "Modularn3"          , 800 },
    { 2012     , "Zidni11"            , 3000},
    { 19640    , "EmptyShopShelf1"    , 3000}
};

enum E_247_MISC_OBJECTS_DATA
{
    smiscId,
    smiscName[20],
    smiscPrice
}
new const Objects247Misc[][E_247_MISC_OBJECTS_DATA] =
{
    {1885 ,    "Shopping Kosare1"    , 100},
    {2365 ,    "Shopping Kosare2"    , 90 },
    {19587,    "Plasticna Kosara"    , 50 },
    {19592,    "Shopping Kosara2"    , 10 },
    {19636,    "Sanduk Jabuka1"      , 10 },
    {19637,    "Sanduk Jabuka2"      , 10 },
    {19638,    "Sanduk Naranci"      , 10 },
    {19638,    "Prazan Sanduk"       , 10 },
    {19573,    "Briketi"             , 15 },
    {19329,    "24/7 Znak1"          , 15 },
    {19326,    "24/7 Znak2"          , 15 },
    {19327,    "24/7 Znak3"          , 15 },
    {19328,    "24/7 Znak4"          , 15 },
    {2729 ,    "Binco Znak"          , 15 },
    {2734 ,    "ZIP Znak"            , 15 },
    {2493 ,    "Igracke1"            , 150},
    {2494 ,    "Igracke2"            , 150},
    {2496 ,    "Igracke3"            , 150},
    {2694 ,    "Kutija za obucu"     , 10 },
    {1513 ,    "Police"              , 30 },
    {1842 ,    "Sanduk hrane1"       , 100},
    {1843 ,    "Sanduk hrane2"       , 120},
    {1844 ,    "Sanduk hrane3"       , 120},
    {1845 ,    "Sanduk hrane4"       , 80 },
    {1847 ,    "Sanduk hrane5"       , 100},
    {1848 ,    "Sanduk hrane6"       , 120},
    {1883 ,    "Sanduk hrane7"       , 100},
    {1884 ,    "Sanduk hrane8"       , 100},
    {1887 ,    "Sanduk hrane9"       , 100},
    {1888 ,    "Sanduk hrane10"      , 150},
    {1889 ,    "Sanduk hrane11"      , 150},
    {1890 ,    "Sanduk hrane12"      , 115},
    {1891 ,    "Sanduk hrane13"      , 80 },
    {2413 ,    "Izlog1"              , 80 },
    {2433 ,    "Izlog2"              , 80 },
    {2436 ,    "Izlog3"              , 80 },
    {2488 ,    "Casopis1"            , 80 },
    {2489 ,    "Casopis2"            , 80 },
    {2490 ,    "Casopis3"            , 80 },
    {2492 ,    "Casopis4"            , 80 },
    {2493 ,    "Casopis5"            , 80 },
    {2494 ,    "Casopis6"            , 80 },
    {2495 ,    "Casopis7"            , 80 },
    {2496 ,    "Casopis8"            , 80 },
    {2495 ,    "Casopis9"            , 80 },
    {-2114,    "Coa beerbottles1"    , 150},
    {-2115,    "Coa beerbottles2"    , 100},
    {-2116,    "Coa beerbottles3"    , 200},
    {-2117,    "Coa beerbottles4"    , 125},
    {-2118,    "Coa beerbottles5"    ,  80},
    {-2119,    "Coa beerbottles6"    , 250},
    {-2120,    "Coa beerbottles7"    , 100},
    {-2121,    "Coa beerbottles8"    , 500}
};

enum E_CASH_REGISTER_OBJECTS_DATA
{
    crId,
    crName[20],
    crPrice
}
new const ObjectsCashRegister[][E_CASH_REGISTER_OBJECTS_DATA] =
{
    {1514,    "Kasa1"             , 100},
    {1959,    "Mala Kasa"         , 90 },
    {2771,    "Fast Food Kasa"    , 120}
};

enum E_REFRIGERATORS_OBJECTS_DATA
{
    refId,
    refName[20],
    refPrice
}
new const ObjectsRefrigerators[][E_REFRIGERATORS_OBJECTS_DATA] =
{
    {2452,    "Dvostruki Hladnjak"    , 500},
    {2529,    "Mali Frizider1"        , 450},
    {2531,    "Mali Frizider2"        , 450}
};

enum E_SHELFS_OBJECTS_DATA
{
    shelfId,
    shelfName[20],
    shelfPrice
}
new const ObjectsShelfs[][E_SHELFS_OBJECTS_DATA] =
{
    {2462 ,    "Hobby Polica"           , 100},
    {2482 ,    "Hobby Polica1"          , 100},
    {2475 ,    "Hobby Polica2"          , 100},
    {2463 ,    "Hobby Polica3"          , 100},
    {1744 ,    "Polica1"                , 100},
    {2400 ,    "Hobby Polica5"          , 100},
    {2708 ,    "Hobby Polica6"          , 100},
    {19938,    "Modern Polica1"         , 200},
    {19939,    "Modern Polica2"         , 200},
    {2089 ,    "Drvena polica"          , 150},
    {2089 ,    "Drvena polica"          , 150},
    {2078 ,    "Starinski ormar"        , 150},
    {2161 ,    "Niska polica1"          , 200},
    {2162 ,    "Niska polica2"          , 100},
    {2163 ,    "Kancelarijski ormar"    , 250},
    {2164 ,    "Ormar sa policom"       , 200},
    {2167 ,    "Uski ormar"             , 120},
    {2191 ,    "Plava polica"           , 215},
    {2200 ,    "Veliki ormar"           , 225},
    {2204 ,    "Ormar sa policom"       , 225},
    {2063 ,    "Stare police"           , 200}
};

enum E_WAREHOUSE_OBJECTS_DATA
{
    whId,
    whName[23],
    whPrice
}
new const ObjectsWareHouse[][E_WAREHOUSE_OBJECTS_DATA] =
{
    {922  ,    "Kutije1"                   , 100 },
    {939  ,    "Polica Kutija"             , 1000},
    {1271 ,    "Kutija"                    , 800 },
    {1431 ,    "Drvene Kutije1"            , 300 },
    {2973 ,    "Cargo Kutija"              , 900 },
    {3630 ,    "Velike Kutije"             , 2500},
    {925  ,    "Bacve"                     , 160 },
    {929  ,    "Generator"                 , 2000},
    {930  ,    "O2 Spremnik"               , 3500},
    {3390 ,    "Stol1"                     , 250 },
    {3391 ,    "Stol2"                     , 250 },
    {3392 ,    "Stol3"                     , 200 },
    {3393 ,    "Stol4"                     , 200 },
    {3394 ,    "Stol5"                     , 225 },
    {3395 ,    "Stol6"                     , 200 },
    {3396 ,    "Stol7"                     , 225 },
    {3397 ,    "Stol8"                     , 180 },
    {11729,    "Ormaric1"                  , 100 },
    {11730,    "Ormaric2"                  , 100 },
    {2332 ,    "Sef"                       , 250 },
    {19813,    "Steker1"                   , 50  },
    {19814,    "Steker2"                   , 50  },
    {19826,    "Prekidac1"                 , 75  },
    {19827,    "Prekidac2"                 , 75  },
    {19828,    "Prekidac3"                 , 75  },
    {19829,    "Prekidac4"                 , 75  },
    {19807,    "Fiksni telefon"            , 100 },
    {19808,    "Tastatura"                 , 100 },
    {2312 ,    "Televizor1"                , 120 },
    {2316 ,    "Televizor2"                , 120 },
    {2317 ,    "Televizor3"                , 150 },
    {2318 ,    "Televizor4"                , 120 },
    {2320 ,    "Televizor5"                , 120 },
    {2322 ,    "Televizor6"                , 150 },
    {1421 ,    "Drvene kutije2"            , 300 },
    {1421 ,    "Drvene kutije2"            , 300 },
    {2254 ,    "Zidna slika1"              , 200 },
    {2255 ,    "Zidna slika2"              , 250 },
    {2256 ,    "Zidna slika3"              , 350 },
    {2257 ,    "Zidna slika4"              , 370 },
    {2258 ,    "Zidna slika5"              , 200 },
    {2259 ,    "Zidna slika6"              , 200 },
    {918  ,    "Bacva1"                    , 150 },
    {1217 ,    "Bacva2"                    , 150 },
    {1218 ,    "Bacva3"                    , 150 },
    {1222 ,    "Bacva4"                    , 150 },
    {1225 ,    "Bacva5"                    , 100 },
    {1464 ,    "Skela1"                    , 500 },
    {1466 ,    "Skela2"                    , 500 },
    {1438 ,    "Kutije2"                   , 150 },
    {1440 ,    "Kutije3"                   , 200 },
    {1441 ,    "Kutije4"                   , 300 },
    {1702 ,    "Svijetlo smedi kauc"       , 100 },
    {1703 ,    "Crni kauc"                 , 100 },
    {1706 ,    "Ljubicasti kauc"           , 100 },
    {1707 ,    "Lazybag kauc"              , 100 },
    {1709 ,    "Ugaona garnitura"          , 150 },
    {1710 ,    "Cetvorosed"                , 100 },
    {1712 ,    "Dvosjed"                   , 100 },
    {1713 ,    "Plavi kauc"                , 100 },
    {1723 ,    "Crni kauc"                 , 150 },
    {1726 ,    "Kauc - crna koza"          , 250 },
    {1728 ,    "Krem dvosed"               , 100 },
    {1753 ,    "Smedi trosed - koza"       , 200 },
    {1756 ,    "Ukraseni dvosed"           , 100 },
    {1757 ,    "Rozi dvosed"               , 150 },
    {1760 ,    "Plavi trosed"              , 250 },
    {1761 ,    "Smedi drveni trosed"       , 100 },
    {1763 ,    "Rozi dvosed - mali"        , 100 },
    {1764 ,    "Braon sofa"                , 100 },
    {1766 ,    "Siva sofa"                 , 100 },
    {1768 ,    "Plavi trosed"              , 100 },
    {2290 ,    "Smedi sofa - trosed"       , 150 },
    {11685,    "Smedi kauc sa naslonom"    , 150 },
    {-2035,    "Kutija oruzje1"            , 800 },
    {-2036,    "Kutija oruzje2"            , 500 },
    {-2037,    "Coa laptop"                , 250 },
    {-2039,    "Coa pepeljara"             , 200 },
    {-2041,    "Coa shisa"                 , 400 },
    {-2042,    "Coa vaga"                  , 200 },
    {-2114,    "Coa beerbottles1"          , 150 },
    {-2115,    "Coa beerbottles2"          , 100 },
    {-2116,    "Coa beerbottles3"          , 200 },
    {-2117,    "Coa beerbottles4"          , 125 },
    {-2118,    "Coa beerbottles5"          ,  80 },
    {-2119,    "Coa beerbottles6"          , 250 },
    {-2120,    "Coa beerbottles7"          , 100 },
    {-2121,    "Coa beerbottles8"          , 500 }
};

enum E_SECURITY_OBJECTS_DATA
{
    secId,
    secName[20],
    secPrice
}
new const ObjectsSecurity[][E_SECURITY_OBJECTS_DATA] =
{
    {1886,    "Sigurnosna Kamera"    , 400 },
    {1892,    "Detektor"             , 4000},
    {1622,    "Sigurnosna Kamera"    , 500 },
    {2886,    "Keypad"               , 150 },
    {1615,    "Alarm"                , 100 },
    {1424,    "Ogradica1"            , 100 },
    {1423,    "Ogradica2"            , 100 },
    {1427,    "Ogradica3"            , 100 },
    {1459,    "Ogradica4"            , 100 },
    {1459,    "Ogradica4"            , 100 }
};

enum E_PARTICLES_OBJECTS_DATA
{
    partId,
    partName[20],
    partPrice
}
new const ObjectsParticles[][E_PARTICLES_OBJECTS_DATA] =
{
    {18732,    "Teargas"             , 1000},
    {18737,    "Wallbust"            , 2500},
    {18671,    "Car Wash"            , 2500},
    {18687,    "Extinguisher"        , 1000},
    {18688,    "Flame"               , 2800},
    {18693,    "Flame2"              , 2800},
    {18692,    "Fire Medium"         , 2800},
    {18691,    "Fire Large"          , 2800},
    {18703,    "Overheat"            , 800 },
    {18697,    "Dust Small"          , 900 },
    {18714,    "Dust Medium"         , 1000},
    {18720,    "Water Splash"        , 500 },
    {18738,    "Fontana1"            , 500 },
    {18739,    "Fontana2"            , 500 },
    {18740,    "Fontana3"            , 500 },
    {18742,    "Fontana4"            , 500 },
    {18728,    "Flare"               , 200 },
    {18727,    "Slow Smoke"          , 100 },
    {18685,    "Explosion Small"     , 3000},
    {18683,    "Explosion Medium"    , 2800},
    {18682,    "Explosion Large"     , 2800}
};