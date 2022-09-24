class TextLoad{
  String[] fileNames;
  String fileIntegral = "maps/fileIntegral.txt";
  TextLoad() {
     fileNames = loadStrings(fileIntegral);
  }
  
  public int[][] mapLoad(int n){
    if (fileNames.length <= n) return null;
    String[] lines = loadStrings("maps/" + fileNames[n]);
    int[] size = int(split(lines[0]," "));
    int[][] map = new int[size[0]][size[1]];
    for (int i = 1; i <= size[1]; i++) {
      int[] s = int(split(lines[i]," "));
      for (int j = 0; j < size[0]; j++) {
        map[j][i - 1] = s[j];
      }
    }

    return map;
  }
}
