import 'package:e_com_task/model/influencer.dart';
import 'package:flutter/material.dart';


class InfluencerCard extends StatelessWidget {
  final Influencer data;
  final VoidCallback onTap;

  const InfluencerCard({super.key, required this.data, required this.onTap});

  Color _badgeColor(String gender) {
    switch (gender) {
      case 'M':
        return Colors.blue;
      case 'F':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: Hero(
          tag: 'influencer_${data.id}',
          child: CircleAvatar(
            backgroundImage:
                (data.image.isNotEmpty) ? NetworkImage(data.image) : null,
            child: (data.image.isEmpty) ? const Icon(Icons.person) : null,
          ),
        ),
        title: Text(data.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Row(
          children: [
            Icon(Icons.circle, size: 10, color: _badgeColor(data.gender)),
            const SizedBox(width: 6),
            Text(data.gender.isEmpty ? 'N/A' : data.gender),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
