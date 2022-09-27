import java.util.Arrays;
import javax.swing.*;
import java.awt.*;

class TextLoad{
  String[] fileNames;
  String fileIntegral = "maps/fileIntegral.txt";
  String[] goalNames;
  String goalIntegral = "goals/goalIntegral.txt";
  
  JPanel panel = new JPanel();
  BoxLayout layout = new BoxLayout (panel, BoxLayout.Y_AXIS);
  
  TextLoad() {
     fileNames = loadStrings(fileIntegral);
     goalNames = loadStrings(goalIntegral);
     
     panel.setLayout(layout);
     panel.add( new JLabel("error 指定されたファイルは存在しません"));
  }
  
  public String getFileName(int n) {
    if (n >= fileNames.length) return null;
    return fileNames[n];
  }
  
  public int getFileNum() {
    return fileNames.length;
  }
  
  public int[][] mapLoad(int n){
    if (fileNames.length <= n) return null;
    String[] lines;
    int[] size;
    try {
      lines = loadStrings("maps/" + fileNames[n]);
      size = int(split(lines[0]," "));
    } catch (Exception e) {
      JOptionPane.showMessageDialog(null, panel, "error", JOptionPane.WARNING_MESSAGE);
      return null;
    }
    
    int[][] map = new int[size[0]][size[1]];
    for (int i = 1; i <= size[1]; i++) {
      int[] s = int(split(lines[i]," "));
      for (int j = 0; j < size[0]; j++) {
        map[j][i - 1] = s[j];
      }
    }

    return map;
  }
  
  public int[][] goalLoad(String str) {
    if (Arrays.asList(fileNames).contains(str)){
      String[] lines = loadStrings("goals/" + str);
      int[] size = int(split(lines[0]," "));
      int[][] map = new int[size[0]][size[1]];
      for (int i = 1; i <= size[1]; i++) {
        int[] s = int(split(lines[i]," "));
        for (int j = 0; j < size[0]; j++) {
          map[j][i - 1] = s[j];
        }
      }
      return map;
    } else {
      return null;
    }
  }
}
