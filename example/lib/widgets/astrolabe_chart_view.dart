import 'package:dart_iztro/crape_myrtle/translations/types/mutagen.dart';
import 'package:dart_iztro/dart_iztro.dart';
import 'package:flutter/material.dart';

class ZiWeiChartView extends StatefulWidget {
  final FunctionalAstrolabe chart;

  const ZiWeiChartView({super.key, required this.chart});

  @override
  State<ZiWeiChartView> createState() => _ZiWeiChartViewState();
}

class _ZiWeiChartViewState extends State<ZiWeiChartView> {
  int? selectedIndex;

  List<int> getRelatedIndices(int base) => [
    base,
    (base + 4) % 12,
    (base + 6) % 12,
    (base + 8) % 12,
  ];

  int getOppositeIndex(int i) => (i + 6) % 12;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellWidth = (constraints.maxWidth < constraints.maxHeight)
            ? constraints.maxWidth / 4
            : constraints.maxHeight / 4;
        final cellHeight = cellWidth * 5 / 4;


        return AspectRatio(
          aspectRatio: 4 / (4 * 5 / 4),
          child: Stack(
            children: [
              for (int i = 0; i < 12; i++)
                Positioned(
                  left: _positions[i].dx * cellWidth,
                  top: _positions[i].dy * cellHeight,
                  width: cellWidth,
                  height: cellHeight,
                  child: GestureDetector(
                    onTap: () => setState(() => selectedIndex = i),
                    child: ZiWeiPalaceCell(
                      palace: widget.chart.palaces[i] as FunctionalPalace,
                      isHighlighted:
                          selectedIndex != null &&
                          (getRelatedIndices(selectedIndex!).contains(i) ||
                              getOppositeIndex(selectedIndex!) == i),
                      isOpposite:
                          selectedIndex != null &&
                          getOppositeIndex(selectedIndex!) == i,
                    ),
                  ),
                ),
              // 中心信息区域位于 CustomPaint 下层
              Positioned(
                left: cellWidth,
                top: cellHeight,
                width: cellWidth * 2,
                height: cellHeight * 2,
                child: _buildCenterInfo(widget.chart),
              ),
              // 在中心区域上方加一层线条绘制
              Positioned(
                left: cellWidth,
                top: cellHeight,
                width: cellWidth * 2,
                height: cellHeight * 2,
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: CenterLinkPainter(
                      selectedIndex: selectedIndex,
                      cellWidth: cellWidth,
                      cellHeight: cellHeight,
                    ),
                    child: Container(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static const List<Offset> _positions = [
    Offset(0, 0),
    Offset(1, 0),
    Offset(2, 0),
    Offset(3, 0),
    Offset(3, 1),
    Offset(3, 2),
    Offset(3, 3),
    Offset(2, 3),
    Offset(1, 3),
    Offset(0, 3),
    Offset(0, 2),
    Offset(0, 1),
  ];

  int calculateAge(String birthDateString) {
    final birthDate = DateTime.parse(birthDateString);
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Widget _buildCenterInfo(FunctionalAstrolabe chart) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade400),
      ),
      padding: const EdgeInsets.all(8),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Text(
              '年龄: ${calculateAge(chart.solarDate)}    性别: ${chart.gender}',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              '命主: ${chart.soul.title}    身主: ${chart.body.title}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              '五行局: ${chart.fiveElementClass.title}    生肖: ${chart.zodiac}    星座: ${chart.sign}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              '阳历: ${chart.solarDate}    阴历: ${chart.lunarDate}',
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              '四柱: ${chart.chineseDate}',
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              '时辰: ${chart.time} (${chart.timeRage})',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class ZiWeiPalaceCell extends StatelessWidget {
  final FunctionalPalace palace;
  final bool isHighlighted;
  final bool isOpposite;

  const ZiWeiPalaceCell({
    super.key,
    required this.palace,
    this.isHighlighted = false,
    this.isOpposite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color:
            isOpposite
                ? Colors.orange.shade100
                : isHighlighted
                ? Colors.yellow.shade100
                : Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStarGrid(palace),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ],
              ),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            '流年: ${palace.yearlies.join(",")}',
            style: const TextStyle(fontSize: 6),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '小限: ${palace.ages.join(",")}',
            style: const TextStyle(fontSize: 6),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '大限: ${palace.decadal.range[0]}–${palace.decadal.range[1]}',
            style: const TextStyle(fontSize: 6),
          ),
          const SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '长生: ${palace.changShen12.title}',
                    style: const TextStyle(fontSize: 6, color: Colors.teal),
                  ),
                  Text(
                    '博士: ${palace.boShi12.title}',
                    style: const TextStyle(fontSize: 6, color: Colors.teal),
                  ),
                  Text(
                    '将前: ${palace.jiangQian12.title}',
                    style: const TextStyle(fontSize: 6, color: Colors.teal),
                  ),
                  Text(
                    '岁前: ${palace.suiQian12.title}',
                    style: const TextStyle(fontSize: 6, color: Colors.teal),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${palace.heavenlySten.title}${palace.earthlyBranch.title}',
                    style: const TextStyle(fontSize: 8),
                  ),
                  Text(
                    palace.name.title,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStarGrid(FunctionalPalace palace) {
    final stars = [
      ...palace.majorStars.map((s) => (s, Colors.red, FontWeight.bold)),
      ...palace.minorStars.map((s) => (s, Colors.purple, FontWeight.normal)),
      ...palace.adjectiveStars.map((s) => (s, Colors.green, FontWeight.normal)),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            stars.map((tuple) {
              final star = tuple.$1;
              final color = tuple.$2 as Color;
              final fontWeight = tuple.$3;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Column(
                  children: [
                    Text(
                      star.name.title,
                      style: TextStyle(
                        fontSize: 9,
                        color: color,
                        fontWeight: fontWeight,
                      ),
                    ),
                    if (star.brightness != null)
                      Text(
                        star.brightness!.title,
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.blueGrey,
                        ),
                      ),
                    if (star.mutagen != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        margin: const EdgeInsets.only(top: 1),
                        decoration: BoxDecoration(
                          color: _getMutagenBackgroundColor(star.mutagen!),
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: Text(
                          star.mutagen!.title,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  Color _getMutagenBackgroundColor(Mutagen title) {
    switch (title) {
      case Mutagen.siHuaJi:
        return Colors.red;
      case Mutagen.siHuaKe:
        return Colors.blue;
      case Mutagen.siHuaQuan:
        return Colors.purple;
      case Mutagen.siHuaLu:
        return Colors.green;
    }
  }
}

class CenterLinkPainter extends CustomPainter {
  final int? selectedIndex;
  final double cellWidth;
  final double cellHeight;

  CenterLinkPainter({
    required this.selectedIndex,
    required this.cellWidth,
    required this.cellHeight,
  });

  static const List<Offset> _positions = _ZiWeiChartViewState._positions;

  Offset _mapToCenterArea(Offset pos) {
    return Offset(
      (pos.dx - 1.0).clamp(0, 2) * cellWidth,
      (pos.dy - 1.0).clamp(0, 2) * cellHeight,
    );
  }

  Offset _centerOf(int i) {
    final p = _positions[i];
    return _mapToCenterArea(Offset(p.dx + 0.5, p.dy + 0.5));
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (selectedIndex == null) return;

    final Paint dashedPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    void drawDashedLine(Offset p1, Offset p2) {
      const dashWidth = 4;
      const dashSpace = 2;
      final delta = p2 - p1;
      final direction = delta / delta.distance;
      final totalLength = delta.distance;
      double drawn = 0;
      while (drawn < totalLength) {
        final start = p1 + direction * drawn;
        final end = p1 + direction * (drawn + dashWidth).clamp(0, totalLength);
        canvas.drawLine(start, end, dashedPaint);
        drawn += dashWidth + dashSpace;
      }
    }

    final a = selectedIndex!;
    final b = (a + 4) % 12;
    final c = (a + 8) % 12;
    final opposite = (a + 6) % 12;

    final pa = _centerOf(a);
    final pb = _centerOf(b);
    final pc = _centerOf(c);
    final po = _centerOf(opposite);

    drawDashedLine(pa, pb);
    drawDashedLine(pb, pc);
    drawDashedLine(pc, pa);
    drawDashedLine(pa, po);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
