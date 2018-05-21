public class ParkLocator {
  public static String[]  country(String Country) {
      ParkService.ParksImplPort park = new ParkService.ParksImplPort();

        return park.byCountry(country);
    }
}