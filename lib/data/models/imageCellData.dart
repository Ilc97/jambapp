class ImageCellData {
  String imagePath;

  ImageCellData({
    required this.imagePath,
  });

  // Converting CellData object into a Map (JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'type': 'ImageCellData',
    };
  }

  // Converting a Map into a CellData object
  factory ImageCellData.fromJson(Map<String, dynamic> json) {
    return ImageCellData(
      imagePath: json['imagePath'],
    );
  }
}
