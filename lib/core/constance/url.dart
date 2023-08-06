abstract class UrlEndpoint{

  static const String baseUrl = "https://fantasy.premierleague.com/api/entry/";
static  getScoreHistory(int leagueId) => "$baseUrl/$leagueId/history/";
static  getTotalScore(String leagueId) => "$baseUrl/$leagueId/";



}
