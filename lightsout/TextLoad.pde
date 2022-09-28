import java.util.Arrays;
import javax.swing.*;
import java.awt.*;

class TextLoad{
  String[] fileNames;
  String fileIntegral = "maps/fileIntegral.txt";
  String[] goalNames;
  String goalIntegral = "goals/goalIntegral.txt";
  private boolean[] goalExist;
  
  private final int SCOREMAX = 5;
  
  JPanel panel = new JPanel();
  BoxLayout layout = new BoxLayout (panel, BoxLayout.Y_AXIS);
  
  TextLoad() {
     fileNames = loadStrings(fileIntegral);
     goalNames = loadStrings(goalIntegral);
     goalExist = new boolean[getFileNum()];
     
     for (int i = 0; i < goalExist.length; i++) {
       goalExist[i] = Arrays.asList(goalNames).contains(fileNames[i]);
     }
     
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
  
  public int[][] goalLoad(int n) {
    if (!goalExist[n]) return null;
    String[] lines = loadStrings("goals/" + getFileName(n));
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
  
  public void saveScore(String str, int count, float time) {
    String[] lines = null;
    try {
      lines = loadStrings("score/" + str);
    } catch (Exception e) {
    
    }
    int[] c;
    float[] t;
    int l;
    if (lines == null || lines.length == 0) {
      l = 1;
      c = new int[l];
      t = new float[l];
      c[0] = count;
      t[0] = time;
    } else {
      l = min(lines.length + 1, SCOREMAX);
      c = new int[l];
      t = new float[l];
      for (int i = 0; i < l && i < lines.length; i++) {
        float[] sc = float(split(lines[i]," "));
        c[i] = (int)sc[0];
        t[i] = sc[1];
      }
      for (int i = l - 1; i >= 0; i--) {
        if (c[i] == 0) continue;
        if(scoreCompare(count, time, c[i], t[i])) {
          if (i < l - 1) {
            c[i + 1] = c[i];
            t[i + 1] = t[i];
            if (i == 0) {
              c[i] = count;
              t[i] = time;
            }
          }
        } else {
          if (i < l - 1) {
            c[i + 1] = count;
            t[i + 1] = time;
          }
          break;
        }
      }
    }
    String[] saveLine = new String[l];
    for (int i = 0; i < l; i++) {
      saveLine[i] = c[i] + " " + t[i];
    }
    saveStrings("score/"+str, saveLine);
  }
  
  public boolean scoreCompare(int c1, float t1, int c2, float t2) {
    return (c1 < c2 || (c1 == c2 && t1 < t2));
  }
  
  public String[] loadScore(String str) {
    return loadStrings("score/" + str);
  }
  
}
