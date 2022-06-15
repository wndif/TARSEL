`timescale 1ns / 1ns
`define M     97          // M is the degree of the irreducible polynomial
`define WIDTH (2*`M-1)    // width for a GF(3^M) element
`define W2    (4*`M-1)    // width for a GF(3^{2*M}) element
`define W3    (6*`M-1)    // width for a GF(3^{3*M}) element
`define W6    (12*`M-1)   // width for a GF(3^{6*M}) element
`define PX    196'h4000000000000000000000000000000000000000001000002 // PX is the irreducible polynomial

module test_duursma_lee_algo;

    // Inputs
    reg clk;
    reg reset;
    reg [`WIDTH:0] xp,yp,xr,yr;

    reg instrument; // instrumentation clock for test bench output

    // Outputs
    wire done;
    wire [`W6:0] out;
    wire [`WIDTH:0] o0,o1,o2,o3,o4,o5;

    integer f;

    // Instantiate the Unit Under Test (UUT)
    duursma_lee_algo uut (
        .clk(clk), 
        .reset(reset), 
        .xp(xp), 
        .yp(yp), 
        .xr(xr), 
        .yr(yr), 
        .done(done), 
        .out(out)
    );
    
    assign {o5,o4,o3,o2,o1,o0} = out;

    initial begin
        f = $fopen("output_test_duursma_lee_algo_t1.txt");
        $fwrite(f, "time,done,out[1163],out[1162],out[1161],out[1160],out[1159],out[1158],out[1157],out[1156],out[1155],out[1154],out[1153],out[1152],out[1151],out[1150],out[1149],out[1148],out[1147],out[1146],out[1145],out[1144],out[1143],out[1142],out[1141],out[1140],out[1139],out[1138],out[1137],out[1136],out[1135],out[1134],out[1133],out[1132],out[1131],out[1130],out[1129],out[1128],out[1127],out[1126],out[1125],out[1124],out[1123],out[1122],out[1121],out[1120],out[1119],out[1118],out[1117],out[1116],out[1115],out[1114],out[1113],out[1112],out[1111],out[1110],out[1109],out[1108],out[1107],out[1106],out[1105],out[1104],out[1103],out[1102],out[1101],out[1100],out[1099],out[1098],out[1097],out[1096],out[1095],out[1094],out[1093],out[1092],out[1091],out[1090],out[1089],out[1088],out[1087],out[1086],out[1085],out[1084],out[1083],out[1082],out[1081],out[1080],out[1079],out[1078],out[1077],out[1076],out[1075],out[1074],out[1073],out[1072],out[1071],out[1070],out[1069],out[1068],out[1067],out[1066],out[1065],out[1064],out[1063],out[1062],out[1061],out[1060],out[1059],out[1058],out[1057],out[1056],out[1055],out[1054],out[1053],out[1052],out[1051],out[1050],out[1049],out[1048],out[1047],out[1046],out[1045],out[1044],out[1043],out[1042],out[1041],out[1040],out[1039],out[1038],out[1037],out[1036],out[1035],out[1034],out[1033],out[1032],out[1031],out[1030],out[1029],out[1028],out[1027],out[1026],out[1025],out[1024],out[1023],out[1022],out[1021],out[1020],out[1019],out[1018],out[1017],out[1016],out[1015],out[1014],out[1013],out[1012],out[1011],out[1010],out[1009],out[1008],out[1007],out[1006],out[1005],out[1004],out[1003],out[1002],out[1001],out[1000],out[999],out[998],out[997],out[996],out[995],out[994],out[993],out[992],out[991],out[990],out[989],out[988],out[987],out[986],out[985],out[984],out[983],out[982],out[981],out[980],out[979],out[978],out[977],out[976],out[975],out[974],out[973],out[972],out[971],out[970],out[969],out[968],out[967],out[966],out[965],out[964],out[963],out[962],out[961],out[960],out[959],out[958],out[957],out[956],out[955],out[954],out[953],out[952],out[951],out[950],out[949],out[948],out[947],out[946],out[945],out[944],out[943],out[942],out[941],out[940],out[939],out[938],out[937],out[936],out[935],out[934],out[933],out[932],out[931],out[930],out[929],out[928],out[927],out[926],out[925],out[924],out[923],out[922],out[921],out[920],out[919],out[918],out[917],out[916],out[915],out[914],out[913],out[912],out[911],out[910],out[909],out[908],out[907],out[906],out[905],out[904],out[903],out[902],out[901],out[900],out[899],out[898],out[897],out[896],out[895],out[894],out[893],out[892],out[891],out[890],out[889],out[888],out[887],out[886],out[885],out[884],out[883],out[882],out[881],out[880],out[879],out[878],out[877],out[876],out[875],out[874],out[873],out[872],out[871],out[870],out[869],out[868],out[867],out[866],out[865],out[864],out[863],out[862],out[861],out[860],out[859],out[858],out[857],out[856],out[855],out[854],out[853],out[852],out[851],out[850],out[849],out[848],out[847],out[846],out[845],out[844],out[843],out[842],out[841],out[840],out[839],out[838],out[837],out[836],out[835],out[834],out[833],out[832],out[831],out[830],out[829],out[828],out[827],out[826],out[825],out[824],out[823],out[822],out[821],out[820],out[819],out[818],out[817],out[816],out[815],out[814],out[813],out[812],out[811],out[810],out[809],out[808],out[807],out[806],out[805],out[804],out[803],out[802],out[801],out[800],out[799],out[798],out[797],out[796],out[795],out[794],out[793],out[792],out[791],out[790],out[789],out[788],out[787],out[786],out[785],out[784],out[783],out[782],out[781],out[780],out[779],out[778],out[777],out[776],out[775],out[774],out[773],out[772],out[771],out[770],out[769],out[768],out[767],out[766],out[765],out[764],out[763],out[762],out[761],out[760],out[759],out[758],out[757],out[756],out[755],out[754],out[753],out[752],out[751],out[750],out[749],out[748],out[747],out[746],out[745],out[744],out[743],out[742],out[741],out[740],out[739],out[738],out[737],out[736],out[735],out[734],out[733],out[732],out[731],out[730],out[729],out[728],out[727],out[726],out[725],out[724],out[723],out[722],out[721],out[720],out[719],out[718],out[717],out[716],out[715],out[714],out[713],out[712],out[711],out[710],out[709],out[708],out[707],out[706],out[705],out[704],out[703],out[702],out[701],out[700],out[699],out[698],out[697],out[696],out[695],out[694],out[693],out[692],out[691],out[690],out[689],out[688],out[687],out[686],out[685],out[684],out[683],out[682],out[681],out[680],out[679],out[678],out[677],out[676],out[675],out[674],out[673],out[672],out[671],out[670],out[669],out[668],out[667],out[666],out[665],out[664],out[663],out[662],out[661],out[660],out[659],out[658],out[657],out[656],out[655],out[654],out[653],out[652],out[651],out[650],out[649],out[648],out[647],out[646],out[645],out[644],out[643],out[642],out[641],out[640],out[639],out[638],out[637],out[636],out[635],out[634],out[633],out[632],out[631],out[630],out[629],out[628],out[627],out[626],out[625],out[624],out[623],out[622],out[621],out[620],out[619],out[618],out[617],out[616],out[615],out[614],out[613],out[612],out[611],out[610],out[609],out[608],out[607],out[606],out[605],out[604],out[603],out[602],out[601],out[600],out[599],out[598],out[597],out[596],out[595],out[594],out[593],out[592],out[591],out[590],out[589],out[588],out[587],out[586],out[585],out[584],out[583],out[582],out[581],out[580],out[579],out[578],out[577],out[576],out[575],out[574],out[573],out[572],out[571],out[570],out[569],out[568],out[567],out[566],out[565],out[564],out[563],out[562],out[561],out[560],out[559],out[558],out[557],out[556],out[555],out[554],out[553],out[552],out[551],out[550],out[549],out[548],out[547],out[546],out[545],out[544],out[543],out[542],out[541],out[540],out[539],out[538],out[537],out[536],out[535],out[534],out[533],out[532],out[531],out[530],out[529],out[528],out[527],out[526],out[525],out[524],out[523],out[522],out[521],out[520],out[519],out[518],out[517],out[516],out[515],out[514],out[513],out[512],out[511],out[510],out[509],out[508],out[507],out[506],out[505],out[504],out[503],out[502],out[501],out[500],out[499],out[498],out[497],out[496],out[495],out[494],out[493],out[492],out[491],out[490],out[489],out[488],out[487],out[486],out[485],out[484],out[483],out[482],out[481],out[480],out[479],out[478],out[477],out[476],out[475],out[474],out[473],out[472],out[471],out[470],out[469],out[468],out[467],out[466],out[465],out[464],out[463],out[462],out[461],out[460],out[459],out[458],out[457],out[456],out[455],out[454],out[453],out[452],out[451],out[450],out[449],out[448],out[447],out[446],out[445],out[444],out[443],out[442],out[441],out[440],out[439],out[438],out[437],out[436],out[435],out[434],out[433],out[432],out[431],out[430],out[429],out[428],out[427],out[426],out[425],out[424],out[423],out[422],out[421],out[420],out[419],out[418],out[417],out[416],out[415],out[414],out[413],out[412],out[411],out[410],out[409],out[408],out[407],out[406],out[405],out[404],out[403],out[402],out[401],out[400],out[399],out[398],out[397],out[396],out[395],out[394],out[393],out[392],out[391],out[390],out[389],out[388],out[387],out[386],out[385],out[384],out[383],out[382],out[381],out[380],out[379],out[378],out[377],out[376],out[375],out[374],out[373],out[372],out[371],out[370],out[369],out[368],out[367],out[366],out[365],out[364],out[363],out[362],out[361],out[360],out[359],out[358],out[357],out[356],out[355],out[354],out[353],out[352],out[351],out[350],out[349],out[348],out[347],out[346],out[345],out[344],out[343],out[342],out[341],out[340],out[339],out[338],out[337],out[336],out[335],out[334],out[333],out[332],out[331],out[330],out[329],out[328],out[327],out[326],out[325],out[324],out[323],out[322],out[321],out[320],out[319],out[318],out[317],out[316],out[315],out[314],out[313],out[312],out[311],out[310],out[309],out[308],out[307],out[306],out[305],out[304],out[303],out[302],out[301],out[300],out[299],out[298],out[297],out[296],out[295],out[294],out[293],out[292],out[291],out[290],out[289],out[288],out[287],out[286],out[285],out[284],out[283],out[282],out[281],out[280],out[279],out[278],out[277],out[276],out[275],out[274],out[273],out[272],out[271],out[270],out[269],out[268],out[267],out[266],out[265],out[264],out[263],out[262],out[261],out[260],out[259],out[258],out[257],out[256],out[255],out[254],out[253],out[252],out[251],out[250],out[249],out[248],out[247],out[246],out[245],out[244],out[243],out[242],out[241],out[240],out[239],out[238],out[237],out[236],out[235],out[234],out[233],out[232],out[231],out[230],out[229],out[228],out[227],out[226],out[225],out[224],out[223],out[222],out[221],out[220],out[219],out[218],out[217],out[216],out[215],out[214],out[213],out[212],out[211],out[210],out[209],out[208],out[207],out[206],out[205],out[204],out[203],out[202],out[201],out[200],out[199],out[198],out[197],out[196],out[195],out[194],out[193],out[192],out[191],out[190],out[189],out[188],out[187],out[186],out[185],out[184],out[183],out[182],out[181],out[180],out[179],out[178],out[177],out[176],out[175],out[174],out[173],out[172],out[171],out[170],out[169],out[168],out[167],out[166],out[165],out[164],out[163],out[162],out[161],out[160],out[159],out[158],out[157],out[156],out[155],out[154],out[153],out[152],out[151],out[150],out[149],out[148],out[147],out[146],out[145],out[144],out[143],out[142],out[141],out[140],out[139],out[138],out[137],out[136],out[135],out[134],out[133],out[132],out[131],out[130],out[129],out[128],out[127],out[126],out[125],out[124],out[123],out[122],out[121],out[120],out[119],out[118],out[117],out[116],out[115],out[114],out[113],out[112],out[111],out[110],out[109],out[108],out[107],out[106],out[105],out[104],out[103],out[102],out[101],out[100],out[99],out[98],out[97],out[96],out[95],out[94],out[93],out[92],out[91],out[90],out[89],out[88],out[87],out[86],out[85],out[84],out[83],out[82],out[81],out[80],out[79],out[78],out[77],out[76],out[75],out[74],out[73],out[72],out[71],out[70],out[69],out[68],out[67],out[66],out[65],out[64],out[63],out[62],out[61],out[60],out[59],out[58],out[57],out[56],out[55],out[54],out[53],out[52],out[51],out[50],out[49],out[48],out[47],out[46],out[45],out[44],out[43],out[42],out[41],out[40],out[39],out[38],out[37],out[36],out[35],out[34],out[33],out[32],out[31],out[30],out[29],out[28],out[27],out[26],out[25],out[24],out[23],out[22],out[21],out[20],out[19],out[18],out[17],out[16],out[15],out[14],out[13],out[12],out[11],out[10],out[9],out[8],out[7],out[6],out[5],out[4],out[3],out[2],out[1],out[0]\n");
    end

    integer flag;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
        xp = 0;
        yp = 0;
        xr = 0;
        yr = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Add stimulus here
        xp = 194'haa5a8129a02a0544a4409a500045458901280969815aa820;
        yp = 194'h1414a205a21a4428968985650895464402249258428049204;
        xr = 194'h614011499522506668a01a20988812468a5aa8641aa24595;
        yr = 194'haa01145590659058124a0261410682860225909182a92189;
        @ (negedge clk); reset = 1;
        @ (negedge clk); reset = 0;
        @ (posedge done);
        #100;
        $fwrite(f, "%g,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n",
            $time,done,out[1163],out[1162],out[1161],out[1160],out[1159],out[1158],out[1157],out[1156],out[1155],out[1154],out[1153],out[1152],out[1151],out[1150],out[1149],out[1148],out[1147],out[1146],out[1145],out[1144],out[1143],out[1142],out[1141],out[1140],out[1139],out[1138],out[1137],out[1136],out[1135],out[1134],out[1133],out[1132],out[1131],out[1130],out[1129],out[1128],out[1127],out[1126],out[1125],out[1124],out[1123],out[1122],out[1121],out[1120],out[1119],out[1118],out[1117],out[1116],out[1115],out[1114],out[1113],out[1112],out[1111],out[1110],out[1109],out[1108],out[1107],out[1106],out[1105],out[1104],out[1103],out[1102],out[1101],out[1100],out[1099],out[1098],out[1097],out[1096],out[1095],out[1094],out[1093],out[1092],out[1091],out[1090],out[1089],out[1088],out[1087],out[1086],out[1085],out[1084],out[1083],out[1082],out[1081],out[1080],out[1079],out[1078],out[1077],out[1076],out[1075],out[1074],out[1073],out[1072],out[1071],out[1070],out[1069],out[1068],out[1067],out[1066],out[1065],out[1064],out[1063],out[1062],out[1061],out[1060],out[1059],out[1058],out[1057],out[1056],out[1055],out[1054],out[1053],out[1052],out[1051],out[1050],out[1049],out[1048],out[1047],out[1046],out[1045],out[1044],out[1043],out[1042],out[1041],out[1040],out[1039],out[1038],out[1037],out[1036],out[1035],out[1034],out[1033],out[1032],out[1031],out[1030],out[1029],out[1028],out[1027],out[1026],out[1025],out[1024],out[1023],out[1022],out[1021],out[1020],out[1019],out[1018],out[1017],out[1016],out[1015],out[1014],out[1013],out[1012],out[1011],out[1010],out[1009],out[1008],out[1007],out[1006],out[1005],out[1004],out[1003],out[1002],out[1001],out[1000],out[999],out[998],out[997],out[996],out[995],out[994],out[993],out[992],out[991],out[990],out[989],out[988],out[987],out[986],out[985],out[984],out[983],out[982],out[981],out[980],out[979],out[978],out[977],out[976],out[975],out[974],out[973],out[972],out[971],out[970],out[969],out[968],out[967],out[966],out[965],out[964],out[963],out[962],out[961],out[960],out[959],out[958],out[957],out[956],out[955],out[954],out[953],out[952],out[951],out[950],out[949],out[948],out[947],out[946],out[945],out[944],out[943],out[942],out[941],out[940],out[939],out[938],out[937],out[936],out[935],out[934],out[933],out[932],out[931],out[930],out[929],out[928],out[927],out[926],out[925],out[924],out[923],out[922],out[921],out[920],out[919],out[918],out[917],out[916],out[915],out[914],out[913],out[912],out[911],out[910],out[909],out[908],out[907],out[906],out[905],out[904],out[903],out[902],out[901],out[900],out[899],out[898],out[897],out[896],out[895],out[894],out[893],out[892],out[891],out[890],out[889],out[888],out[887],out[886],out[885],out[884],out[883],out[882],out[881],out[880],out[879],out[878],out[877],out[876],out[875],out[874],out[873],out[872],out[871],out[870],out[869],out[868],out[867],out[866],out[865],out[864],out[863],out[862],out[861],out[860],out[859],out[858],out[857],out[856],out[855],out[854],out[853],out[852],out[851],out[850],out[849],out[848],out[847],out[846],out[845],out[844],out[843],out[842],out[841],out[840],out[839],out[838],out[837],out[836],out[835],out[834],out[833],out[832],out[831],out[830],out[829],out[828],out[827],out[826],out[825],out[824],out[823],out[822],out[821],out[820],out[819],out[818],out[817],out[816],out[815],out[814],out[813],out[812],out[811],out[810],out[809],out[808],out[807],out[806],out[805],out[804],out[803],out[802],out[801],out[800],out[799],out[798],out[797],out[796],out[795],out[794],out[793],out[792],out[791],out[790],out[789],out[788],out[787],out[786],out[785],out[784],out[783],out[782],out[781],out[780],out[779],out[778],out[777],out[776],out[775],out[774],out[773],out[772],out[771],out[770],out[769],out[768],out[767],out[766],out[765],out[764],out[763],out[762],out[761],out[760],out[759],out[758],out[757],out[756],out[755],out[754],out[753],out[752],out[751],out[750],out[749],out[748],out[747],out[746],out[745],out[744],out[743],out[742],out[741],out[740],out[739],out[738],out[737],out[736],out[735],out[734],out[733],out[732],out[731],out[730],out[729],out[728],out[727],out[726],out[725],out[724],out[723],out[722],out[721],out[720],out[719],out[718],out[717],out[716],out[715],out[714],out[713],out[712],out[711],out[710],out[709],out[708],out[707],out[706],out[705],out[704],out[703],out[702],out[701],out[700],out[699],out[698],out[697],out[696],out[695],out[694],out[693],out[692],out[691],out[690],out[689],out[688],out[687],out[686],out[685],out[684],out[683],out[682],out[681],out[680],out[679],out[678],out[677],out[676],out[675],out[674],out[673],out[672],out[671],out[670],out[669],out[668],out[667],out[666],out[665],out[664],out[663],out[662],out[661],out[660],out[659],out[658],out[657],out[656],out[655],out[654],out[653],out[652],out[651],out[650],out[649],out[648],out[647],out[646],out[645],out[644],out[643],out[642],out[641],out[640],out[639],out[638],out[637],out[636],out[635],out[634],out[633],out[632],out[631],out[630],out[629],out[628],out[627],out[626],out[625],out[624],out[623],out[622],out[621],out[620],out[619],out[618],out[617],out[616],out[615],out[614],out[613],out[612],out[611],out[610],out[609],out[608],out[607],out[606],out[605],out[604],out[603],out[602],out[601],out[600],out[599],out[598],out[597],out[596],out[595],out[594],out[593],out[592],out[591],out[590],out[589],out[588],out[587],out[586],out[585],out[584],out[583],out[582],out[581],out[580],out[579],out[578],out[577],out[576],out[575],out[574],out[573],out[572],out[571],out[570],out[569],out[568],out[567],out[566],out[565],out[564],out[563],out[562],out[561],out[560],out[559],out[558],out[557],out[556],out[555],out[554],out[553],out[552],out[551],out[550],out[549],out[548],out[547],out[546],out[545],out[544],out[543],out[542],out[541],out[540],out[539],out[538],out[537],out[536],out[535],out[534],out[533],out[532],out[531],out[530],out[529],out[528],out[527],out[526],out[525],out[524],out[523],out[522],out[521],out[520],out[519],out[518],out[517],out[516],out[515],out[514],out[513],out[512],out[511],out[510],out[509],out[508],out[507],out[506],out[505],out[504],out[503],out[502],out[501],out[500],out[499],out[498],out[497],out[496],out[495],out[494],out[493],out[492],out[491],out[490],out[489],out[488],out[487],out[486],out[485],out[484],out[483],out[482],out[481],out[480],out[479],out[478],out[477],out[476],out[475],out[474],out[473],out[472],out[471],out[470],out[469],out[468],out[467],out[466],out[465],out[464],out[463],out[462],out[461],out[460],out[459],out[458],out[457],out[456],out[455],out[454],out[453],out[452],out[451],out[450],out[449],out[448],out[447],out[446],out[445],out[444],out[443],out[442],out[441],out[440],out[439],out[438],out[437],out[436],out[435],out[434],out[433],out[432],out[431],out[430],out[429],out[428],out[427],out[426],out[425],out[424],out[423],out[422],out[421],out[420],out[419],out[418],out[417],out[416],out[415],out[414],out[413],out[412],out[411],out[410],out[409],out[408],out[407],out[406],out[405],out[404],out[403],out[402],out[401],out[400],out[399],out[398],out[397],out[396],out[395],out[394],out[393],out[392],out[391],out[390],out[389],out[388],out[387],out[386],out[385],out[384],out[383],out[382],out[381],out[380],out[379],out[378],out[377],out[376],out[375],out[374],out[373],out[372],out[371],out[370],out[369],out[368],out[367],out[366],out[365],out[364],out[363],out[362],out[361],out[360],out[359],out[358],out[357],out[356],out[355],out[354],out[353],out[352],out[351],out[350],out[349],out[348],out[347],out[346],out[345],out[344],out[343],out[342],out[341],out[340],out[339],out[338],out[337],out[336],out[335],out[334],out[333],out[332],out[331],out[330],out[329],out[328],out[327],out[326],out[325],out[324],out[323],out[322],out[321],out[320],out[319],out[318],out[317],out[316],out[315],out[314],out[313],out[312],out[311],out[310],out[309],out[308],out[307],out[306],out[305],out[304],out[303],out[302],out[301],out[300],out[299],out[298],out[297],out[296],out[295],out[294],out[293],out[292],out[291],out[290],out[289],out[288],out[287],out[286],out[285],out[284],out[283],out[282],out[281],out[280],out[279],out[278],out[277],out[276],out[275],out[274],out[273],out[272],out[271],out[270],out[269],out[268],out[267],out[266],out[265],out[264],out[263],out[262],out[261],out[260],out[259],out[258],out[257],out[256],out[255],out[254],out[253],out[252],out[251],out[250],out[249],out[248],out[247],out[246],out[245],out[244],out[243],out[242],out[241],out[240],out[239],out[238],out[237],out[236],out[235],out[234],out[233],out[232],out[231],out[230],out[229],out[228],out[227],out[226],out[225],out[224],out[223],out[222],out[221],out[220],out[219],out[218],out[217],out[216],out[215],out[214],out[213],out[212],out[211],out[210],out[209],out[208],out[207],out[206],out[205],out[204],out[203],out[202],out[201],out[200],out[199],out[198],out[197],out[196],out[195],out[194],out[193],out[192],out[191],out[190],out[189],out[188],out[187],out[186],out[185],out[184],out[183],out[182],out[181],out[180],out[179],out[178],out[177],out[176],out[175],out[174],out[173],out[172],out[171],out[170],out[169],out[168],out[167],out[166],out[165],out[164],out[163],out[162],out[161],out[160],out[159],out[158],out[157],out[156],out[155],out[154],out[153],out[152],out[151],out[150],out[149],out[148],out[147],out[146],out[145],out[144],out[143],out[142],out[141],out[140],out[139],out[138],out[137],out[136],out[135],out[134],out[133],out[132],out[131],out[130],out[129],out[128],out[127],out[126],out[125],out[124],out[123],out[122],out[121],out[120],out[119],out[118],out[117],out[116],out[115],out[114],out[113],out[112],out[111],out[110],out[109],out[108],out[107],out[106],out[105],out[104],out[103],out[102],out[101],out[100],out[99],out[98],out[97],out[96],out[95],out[94],out[93],out[92],out[91],out[90],out[89],out[88],out[87],out[86],out[85],out[84],out[83],out[82],out[81],out[80],out[79],out[78],out[77],out[76],out[75],out[74],out[73],out[72],out[71],out[70],out[69],out[68],out[67],out[66],out[65],out[64],out[63],out[62],out[61],out[60],out[59],out[58],out[57],out[56],out[55],out[54],out[53],out[52],out[51],out[50],out[49],out[48],out[47],out[46],out[45],out[44],out[43],out[42],out[41],out[40],out[39],out[38],out[37],out[36],out[35],out[34],out[33],out[32],out[31],out[30],out[29],out[28],out[27],out[26],out[25],out[24],out[23],out[22],out[21],out[20],out[19],out[18],out[17],out[16],out[15],out[14],out[13],out[12],out[11],out[10],out[9],out[8],out[7],out[6],out[5],out[4],out[3],out[2],out[1],out[0]);
        #100;
        if (out !== {{194'h289898988a561125505a60640642444905248262004845aa6,194'ha6a208a8402504225588a080a124292404061158a96a6a44},{194'h2266261625a9894a45640906a242a99295816525895a98a25,194'h21868921614220506a96a9285119405a15550801829589214},{194'h26a4200680102269189946046919aa804602128246999685a,194'h1a558028a5a964224120a9212a9089a0966a0918a41612219}})
          begin
            $display("E");
            $display("o0=%h",o0);
            $display("o1=%h",o1);
            $display("o2=%h",o2);
            $display("o3=%h",o3);
            $display("o4=%h",o4);
            $display("o5=%h",o5);
            flag <= 1;
          end
        #100;
        if (flag !== 1) $display("Success!");
        $finish;
    end
    
    always #5 clk = ~clk;
endmodule

