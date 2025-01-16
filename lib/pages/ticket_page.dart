import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:intl/intl.dart';

class TicketPage extends StatelessWidget {
  final String eventName;
  final String eventPrice;
  const TicketPage(
      {super.key, required this.eventName, required this.eventPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E251A),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.05,
                  vertical: constraints.maxHeight * 0.02,
                ),
                child: Column(
                  children: [
                    _buildHeader(context),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    _buildTicketPreview(context, constraints),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    _buildMainTicket(context, constraints),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    _buildActions(context, constraints),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'Ticket',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        IconButton(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTicketPreview(BuildContext context, BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight * 0.35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(
          'images/bookworm_logo.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMainTicket(BuildContext context, BoxConstraints constraints) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Left circle cutout
              Positioned(
                left: -10,
                top: constraints.maxHeight * 0.25,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E251A),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Right circle cutout
              Positioned(
                right: -10,
                top: constraints.maxHeight * 0.25,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E251A),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Main content
              Padding(
                padding: EdgeInsets.all(constraints.maxWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTicketHeader(context),
                    const SizedBox(height: 20),
                    _buildDivider(),
                    const SizedBox(height: 20),
                    _buildTicketDetails(context),
                    const SizedBox(height: 20),
                    _buildDivider(),
                    const SizedBox(height: 20),
                    _buildBarcode(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTicketHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ticket #4355",
          style: TextStyle(
            fontFamily: 'Urbanist',
            color: Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          eventName,
          style: const TextStyle(
            fontFamily: 'Urbanist',
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "BookNest",
          style: TextStyle(
            fontFamily: 'Urbanist',
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 1,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  Widget _buildTicketDetails(BuildContext context) {
    final List<TicketDetailItem> details = [
      TicketDetailItem(
        title: "Date",
        value: DateFormat('MMMM dd, yyyy').format(DateTime(2024, 11, 29)),
        alignment: CrossAxisAlignment.start,
      ),
      TicketDetailItem(
        title: "Time",
        value: "09:00 PM",
        alignment: CrossAxisAlignment.end,
      ),
      TicketDetailItem(
        title: "Venue",
        value: "Town Hall, Bangalore",
        alignment: CrossAxisAlignment.start,
      ),
      TicketDetailItem(
        title: "Price",
        value: eventPrice,
        alignment: CrossAxisAlignment.end,
      ),
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: details
              .sublist(0, 2)
              .map((detail) => Expanded(child: detail.build(context)))
              .toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: details
              .sublist(2)
              .map((detail) => Expanded(child: detail.build(context)))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildBarcode(BuildContext context) {
    return Center(
      child: BarcodeWidget(
        barcode: Barcode.code128(),
        data: 'TICKET-4355-BANGALOREFEST',
        width: double.infinity,
        height: 70,
        drawText: false,
      ),
    );
  }

  Widget _buildActions(BuildContext context, BoxConstraints constraints) {
    return Column(
      children: [
        _buildActionButton(
          context: context,
          label: "Download Ticket",
          icon: Icons.download_rounded,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          onPressed: () {
            // Implement download functionality
          },
        ),
        SizedBox(height: constraints.maxHeight * 0.02),
        _buildActionButton(
          context: context,
          label: "Share Ticket",
          icon: Icons.share_rounded,
          backgroundColor: const Color(0xFF10FF03),
          textColor: Colors.black,
          onPressed: () {
            // Implement share functionality
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: textColor),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketDetailItem {
  final String title;
  final String value;
  final CrossAxisAlignment alignment;

  TicketDetailItem({
    required this.title,
    required this.value,
    required this.alignment,
  });

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Urbanist',
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Urbanist',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
