class MapWrite{
  String file = "maps/m.txt";
  String ansFile = "goals/m.txt";
  MapWrite(){}
  
  void setMapName(int x, int y) {
    file = "maps/新規マップ_" + x + "×" + y + "_★.txt";
    ansFile = "goals/新規マップ_" + x + "×" + y + "_★.txt";
  }
  
  void save(int[][] map, int x, int y) {
    String[] list = new String[y + 1];
    list[0] = x + " " + y;
    for (int i = 1; i <= y; i++) {
      list[i] = "";
    }
    for (int i = 1; i <= y; i++) {
      for (int j = 0; j < x; j++) {
        list[i] += map[j][i - 1] + " ";
      }
    }
    saveStrings(file, list);
  }
  
  void saveAns(int[][] goal, int x, int y) {
    String[] list = new String[y + 1];
    list[0] = x + " " + y;
    for (int i = 1; i <= y; i++) {
      list[i] = "";
    }
    for (int i = 1; i <= y; i++) {
      for (int j = 0; j < x; j++) {
        list[i] += goal[j][i - 1] + " ";
      }
    }
    saveStrings(ansFile, list);
  }
}
