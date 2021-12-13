require 'set'

raw_dots, raw_folds = test.split("\n\n")
raw_dots, raw_folds = DATA.read.split("\n\n")
dots = raw_dots.lines(chomp: true).map { |line| line.split(?,).map(&:to_i).freeze }.to_set.freeze
folds = raw_folds.lines(chomp: true).map { |line|
  loc = line.split[-1]
  axis, coord = loc.split(?=)
  [axis, coord.to_i].freeze
}.freeze


def fold(dots, axis, coord)
  new_dots = Set.new
  dots.each { |dot|
    x, y = dot

    if axis == "x"
      if x < coord
        new_dots << dot
      else
        new_dots << [2 * coord - x, y]
      end
    else
      if y < coord
        new_dots << dot
      else
        new_dots << [x, 2 * coord - y]
      end
    end
  }

  new_dots
end

def print_dots(dots)
  xs = dots.min_by(&:first).first..dots.max_by(&:first).first
  ys = dots.min_by(&:last).last..dots.max_by(&:last).last

  ys.each { |y|
    puts xs.map { |x|
      dots.include?([x, y]) ? '#' : '.'
    }.join
  }
end

folds.each_with_index { |(axis, coord), i|
  dots = fold(dots, axis, coord)
  puts dots.length if i == 0
}

print_dots(dots)

__END__
949,224
398,211
402,700
900,890
1197,304
333,809
681,705
769,864
975,465
639,523
445,313
912,99
502,894
703,343
572,598
1232,759
277,640
700,761
919,429
678,141
1054,795
934,750
760,73
268,627
336,859
1096,135
646,176
55,404
932,872
1168,338
569,842
904,863
647,168
509,606
42,525
607,343
947,861
1002,537
1230,368
186,274
363,690
1073,663
868,312
646,718
385,210
961,660
1277,0
470,228
127,705
894,89
500,704
994,361
87,582
985,378
557,607
75,872
1068,647
686,138
358,84
957,415
325,516
711,169
1287,252
619,242
329,516
821,714
514,844
632,358
549,252
442,302
619,652
5,809
276,530
15,75
653,266
632,536
731,648
237,231
1266,19
966,205
360,37
522,3
1255,725
833,840
898,728
805,162
294,261
1250,833
403,151
1288,564
7,465
350,274
1133,478
408,526
1079,493
310,205
420,507
1310,596
639,824
328,257
30,417
845,511
196,683
1002,201
719,96
15,457
276,812
760,43
979,95
319,429
661,429
654,298
584,421
372,355
351,252
430,453
113,304
701,772
107,628
549,700
629,551
492,851
427,101
278,666
246,856
194,82
417,439
433,712
425,229
308,89
1275,652
1193,316
482,190
955,245
465,511
688,37
788,525
92,235
644,417
1247,877
25,327
1255,404
502,0
960,760
431,570
741,702
728,606
1086,453
1198,694
181,208
401,327
959,194
729,863
1295,819
7,271
263,456
132,868
318,849
242,726
1133,392
631,294
410,302
654,582
649,465
622,709
805,284
1300,533
731,22
579,470
177,392
1079,849
252,397
898,871
634,618
427,653
433,630
1228,851
686,865
1079,32
105,252
372,761
15,864
644,222
1134,122
572,851
1303,429
991,726
304,620
962,446
899,586
667,44
786,228
719,93
411,742
1031,110
33,0
646,483
482,288
885,47
1250,609
632,330
594,833
1178,868
68,542
482,480
818,851
278,592
898,726
141,660
360,857
515,651
30,532
865,540
1168,500
1022,525
80,526
975,429
401,159
1256,523
1300,809
410,598
537,540
482,606
25,551
229,709
1096,555
952,756
23,70
584,38
810,288
495,416
278,358
900,43
550,43
895,582
1221,213
1205,252
1180,732
524,3
850,641
1054,421
865,581
376,37
751,233
72,64
969,717
1032,666
1170,50
112,200
279,784
818,43
810,704
972,222
738,296
1285,791
162,403
333,85
1168,786
1161,51
840,498
3,351
966,644
522,891
666,222
751,592
842,50
480,446
885,847
7,623
137,638
1208,703
668,716
477,416
1307,351
981,555
117,578
430,254
1280,417
428,809
743,312
634,620
1225,724
10,869
631,700
87,312
1237,689
388,285
358,810
1111,894
1133,499
113,752
666,670
1198,200
196,451
1079,302
1098,521
987,95
1295,523
1275,591
1131,855
440,583
1171,691
955,201
112,135
291,861
50,588
1032,358
678,330
689,446
30,815
411,152
505,610
251,246
1052,430
427,793
1173,383
1143,431
607,791
189,32
1057,7
1307,543
1173,374
430,677
313,289
624,756
1048,429
1205,70
231,862
947,690
966,250
1220,851
1253,210
269,427
850,701
1034,812
748,211
868,73
279,110
664,624
971,506
1009,327
214,555
80,632
1136,648
1133,854
557,5
997,605
1079,45
174,648
159,351
341,717
934,218
549,194
1079,862
774,467
423,177
1126,50
1039,255
154,717
1256,75
1006,620
1136,757
73,831
65,441
95,415
0,596
455,33
460,641
528,427
15,437
627,201
142,786
714,386
922,144
97,606
455,57
1084,309
840,725
840,396
428,533
679,600
607,103
965,662
674,542
199,894
691,425
728,382
636,352
251,85
149,527
181,686
253,119
1124,172
1059,757
25,383
15,371
540,347
793,638
1305,809
1221,231
681,479
870,107
818,512
427,457
174,757
559,233
1263,343
11,626
174,246
44,875
211,453
1000,250
160,714
802,698
181,9
883,101
994,415
1262,106
715,548
934,228
378,82
262,429
23,252
495,351
885,665
656,582
1111,837
609,324
704,788
994,733
348,620
877,642
971,850
1242,430
513,234
341,157
221,476
443,441
159,767
907,295
1287,824
622,485
1297,659
863,455
1266,133
596,386
1042,85
566,805
711,404
1019,204
904,479
1310,760
1164,877
1054,235
986,392
952,84
468,50
231,302
1159,716
979,799
1178,815
686,29
336,35
796,844
1059,375
445,130
644,533
865,537
542,86
1130,129
1196,750
162,627
95,849
339,492
1173,256
489,597
972,415
877,630
885,717
726,38
1288,834
934,302
870,364
711,649
773,130
410,43
1133,395
1091,714
900,296
258,240
1144,852
982,596
1129,885
960,386
786,443
378,872
1130,765
348,274
1230,526
415,312
729,31
1180,162
793,704
448,525
149,630
816,180
555,121
974,45
1143,687
214,87
48,788
499,367
412,728
796,396
1260,812
679,376
65,383
591,96
512,52
420,828
589,889
435,649
149,591
1114,666
231,849
1151,351
64,205
1240,856
970,436
145,457
579,648
50,193
1168,108
22,834
885,495
1218,235
70,347
1293,353
632,834
278,857
1213,453
971,268
514,396
957,479
619,649
490,736
1302,849
1086,640
890,380
619,591
671,70
159,655
10,421
862,369
441,192
818,64
1183,705
679,824
1196,185
114,302
633,660
1228,40
435,245
256,235
651,351
410,296
947,21
992,859
89,213
482,177
112,459
999,630
774,203
763,628
985,516
1261,640
828,187
562,211
923,10
87,309
1146,736
512,500
305,234
1295,371
647,271
1096,584
508,353
1297,812
972,448
688,485
1081,512
104,403
401,703
1073,231
311,883
833,812
1032,857
239,582
503,716
343,152
664,176
1168,672
167,207
401,775
1116,474
398,683
331,799
952,532
1228,647
1287,600
908,642
402,642
355,245
335,465
788,891
678,536
8,493
318,859
1235,872
177,873
748,659
242,168
796,641
440,331
162,491
1171,203
477,840
350,162
524,666
591,877
22,330
962,274
629,567
977,809
828,480
291,413
1211,569
1193,764
468,274
805,591
395,45
589,511
1299,388
883,437
1302,483
1097,702
868,821
423,401
972,446
30,79
376,218
899,742
339,44
721,63
67,54
795,651
353,415
805,723
246,247
261,5
1047,456
706,82
344,644
1170,760
984,596
493,297
253,735
349,234
155,840
349,660
736,695
994,670
199,837
221,712
423,65
1083,101
386,732
346,245
1133,873
1121,63
1255,714
880,441
514,641
1299,836
1108,33
1278,400
241,500
788,79
1056,569
810,190
584,856
1043,548
1285,103
1288,249
1004,274
1034,530
244,890
1192,691
401,31
155,591
72,736
351,642
487,416
934,37
319,255
1136,137
442,73
169,170
1295,75
862,525
388,526
831,58
1119,649
411,84
902,247
253,7
840,617
1000,196
821,138
1000,205
710,819
13,235
914,654
1161,527
1262,261
492,830
455,705
622,185
1047,793
140,760
1275,649
316,733
345,662
267,884
1141,618
1299,58
440,107
991,175
852,451
23,824
375,110
468,172
541,590
1001,801
773,481
442,373
788,369
500,288
960,610
894,252
224,631
1111,189
1059,533
1029,716
114,709
768,883
541,752
1076,514
1277,894
1133,306
202,861
798,52
845,383
647,726
833,416
584,473
841,234
1245,5
30,756
818,267
885,512
572,488
417,614
1155,840
774,691
149,51
786,732
10,701
689,33
440,364
681,63
643,44
294,633
786,666
411,586
256,795
793,714
32,494
768,135
378,530
196,228
164,736
822,490
495,767
105,264
1073,679
445,242
719,877
146,698
1262,358
736,526
1237,831
965,93
177,588
877,712
75,22
887,65
915,849
1016,261
22,141
227,457
540,99
8,411
701,570
629,343
261,453
154,707
117,255
72,830
691,652
751,302
447,455
890,507
209,354
1238,736
338,448
574,526
1000,698
324,502
1066,4
44,19
632,60
768,459
25,567
1034,364
949,670
231,829
924,610
166,42
703,103
738,851
212,521
898,168
664,718
683,201
358,756
45,527
1235,22
666,533
686,756
132,369
1252,715
1016,270
828,288
226,309
358,138
1066,247
960,162
517,399
401,607
301,327
8,483
482,704
882,585
744,805
406,863
1148,627
44,133
1253,684
1129,9
1193,191
815,351
738,406
388,592
515,243
155,303
447,439
917,677
1041,609
10,361
137,383
858,861
1012,441
1173,404
1041,427
137,520
442,750
166,852
147,263
835,396
912,211
209,481
879,570
959,600
495,655
1119,21
253,241
631,642
492,512
719,798
344,205
599,245
997,289
703,791
1124,274
1071,582
909,607

fold along x=655
fold along y=447
fold along x=327
fold along y=223
fold along x=163
fold along y=111
fold along x=81
fold along y=55
fold along x=40
fold along y=27
fold along y=13
fold along y=6
