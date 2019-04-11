
public class Hurricane {

  public PVector[] points;
  
  private Table track;
  
  private String name;
  /**
   * 
   */
  public Hurricane() {
    super();
  }
  /**
   * @param name
   * @param year
   * @param start_date
   * @param end_date
   * @param land_fallx
   * @param land_fally
   */
  public Hurricane(String name, int year, int start_date, int end_date, int land_fallx, int land_fally) {
    super();
    this.name = name;
    this.year = year;
    this.start_date = start_date;
    this.end_date = end_date;
    this.land_fallx = land_fallx;
    this.land_fally = land_fally;
  }
  private int year;
  private int start_date;
  private int end_date;
  private int land_fallx;
  private int land_fally;
  
  /**
   * @return the track
   */
  public Table getTrack() {
    return track;
  }
  /**
   * @param track the track to set
   */
  public void setTrack(Table track) {
    this.track = track;
  }
  /**
   * @return the year
   */
  public int getYear() {
    return year;
  }
  /**
   * @return the end_date
   */
  public int getEnd_date() {
    return end_date;
  }
  /**
   * @return the land_fallx
   */
  public int getLand_fallx() {
    return land_fallx;
  }
  /**
   * @return the land_fally
   */
  public int getLand_fally() {
    return land_fally;
  }
  /**
   * @param name the name to set
   */
  public void setName(String name) {
    this.name = name;
  }
  /**
   * @param start_date the start_date to set
   */
  public void setStart_date(int start_date) {
    this.start_date = start_date;
  }
  

    
}
