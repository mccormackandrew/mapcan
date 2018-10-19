# Because it is hard to find dataset on 2018 results, I use the list that CTV published after the election
# https://montreal.ctvnews.ca/quebec-2018-election-final-results-and-winners-by-riding-1.4117466

qc_string <- c("Abitibi-Est: Pierre Dufour (CAQ) 42.2%",
               "Abitibi-Ouest: Suzanne Blais (CAQ) 34.1%",
               "Acadie: Christine St-Pierre (LIB) 53.8%",
               "Anjou-Louis-Riel: Lise Theriault (LIB) 39.1%",
               "Argenteuil: Agnes Grondin (CAQ) 38.9%",
               "Arthabasca: Eric Lefebvre (CAQ) 61.8%",
               "Beauce-Nord: Luc Provencal (CAQ) 66.4%",
               "Beauce-Sud: Samuel Poulin (CAQ) 62.7%",
               "Beauharnois: Claude Reid (CAQ) 46.9%",
               "Bellechasse: Stephanie Lachance (CAQ) 53.8%",
               "Berthier: Caroline Proulx (CAQ) 45.1%",
               "Bertrand: Nadine Grault (CAQ) 41.6%",
               "Blainville: Mario Laframboise (CAQ) 48.3%",
               "Bonaventure: Sylvain Roy (PQ) 38.5%",
               "Borduas: Simon Jolin-Barrette (CAQ) 47.7%",
               "Bourassa-Sauve: Paule Robitaille (LIB) 46.2%",
               "Bourget: Richard Campeau (CAQ) 27.6%",
               "Brome-Missisquoi: Isabelle Charest (CAQ) 44.4%",
               "Chambly: Jean-Francois Roberge (CAQ) 50.1%",
               "Champlain: Sonia LeBel (CAQ) 51.9%",
               "Chapleau: Mathieu Levesque (CAQ) 40.4%",
               "Charlesbourg: Jonatan Julien (CAQ) 48.1%",
               "Charlevoix-Cote-de-Beaupre:  Emilie Foster (CAQ) 45.5%",
               "Chateauguay: Marie-Chantal Chasse (CAQ) 37.1%",
               "Chauveau: Sylvain Levesque (CAQ) 47.1%",
               "Chicoutimi: Andree Laforest (CAQ) 39.3%",
               "Chomedey: Guy Ouellette (LIB) 52.7%",
               "Chutes-de-la-Chaudiere: Marc Picard (CAQ) 59.5%",
               "Cote-du-Sud: Marie-Eve Proulx (CAQ) 53.5%",
               "D’Arcy McGee: David Birnbaum (LIB) 74.4%",
               "Deux-Montagnes: Benoit Charette (CAQ) 47.5%",
               "Drummond-Bois-Francs: Sebastien Schneeberger (CAQ) 56.3%",
               "Dubuc: Framcois Tremblay (CAQ) 40.2%",
               "Duplessis: Lorraine Richard (PQ) 34.3%",
               "Fabre: Monique Sauve (LIB) 37.7%",
               "Gaspé: Meganne Perry Melancon (PQ) 33.4%",
               "Gatineau: Robert Bussiere (CAQ) 41.8%",
               "Gouin: Gabriel Nadeau-Dubois (QS) 59.1%",
               "Granby: Francois Bonnardel (CAQ) 62.3%",
               "Groulx: Eric Girard (CAQ) 40.6%",
               "Hochelaga-Maisonneuve: Alexandre Leduc (QS) 49.7%",
               "Hull: Maryse Gaudreault (LIB) 33.7%",
               "Huntingdon: Claire IsaBelle (CAQ) 37.4%",
               "Iberville: Claire Samson (CAQ) 47.4%",
               "Iles-de-la-Madeleine: Joel Arseneau (PQ) 38.7%",
               "Jacques-Cartier: Gregory Kelley (LIB) 71.8%",
               "Jean-Lesage: Sol Zanetti (QS) 34.7%",
               "Jeanne-Mance-Viger: Filomena Rotiroti (LIB) 66.2%",
               "Jean-Talon: Sebastien Proulx (LIB) 32.6%",
               "Johnson: Andre Lamontagne (CAQ) 53.0%",
               "Joliette: Veronique Hivon (PQ) 46.0%",
               "Jonquiere: Sylvain Gaudreault (PQ) 48.4%",
               "Labelle: Chantale Jeanotte (CAQ) 36.6%",
               "Lac-Saint-Jean: Eric Girard (CAQ) 39.3%",
               "LaFontaine: Marc Tanguay (LIB) 58.8%",
               "La Peltrie: Eric Caire (CAQ) 57.7%",
               "La Piniere: Gaetan Barrette (LIB) 47.1%",
               "Laporte: Nicole Menard (LIB) 35.6%",
               "La Prairie: Christian Dube (CAQ) 43.1%",
               "L’Assomption: Francois Legault (CAQ) 57.0%",
               "Laurier-Dorion: Andres Fontecilla (QS) 47.3%",
               "Laval-des-Rapides: Saul Polo (LIB) 31.6%",
               "Laviolette Saint-Maurice: Marie-Louise Tardif (CAQ) 45.4%",
               "Les Plaines: Lucie Lecours (CAQ) 50.8%",
               "Levis: Francois Paradis (CAQ) 57.3%",
               "Lotbiniere-Frontenac: Isabelle Lecours (CAQ) 53.7%",
               "Louis-Hebert: Genevieve Guilbault (CAQ) 44.6%",
               "Marguerite-Bourgeoys: Helene David (LIB) 53.4%",
               "Marie-Victorin: Catherine Fournier (PQ) 30.8%",
               "Marquette: Enrico Ciccone (LIB) 43.0%",
               "Maskinonge: Simon Allaire (CAQ) 42.4%",
               "Masson: Mathieu Lemay (CAQ) 52.9%",
               "Matane-Matapedia: Pascal Berubé (PQ) 69.4%",
               "Maurice-Richard: Marie Montpetit (LIB) 29.5%",
               "Megantic: Francois Jacques (CAQ) 47.5%",
               "Mercier: Ruba Ghazal (QS) 54.5%",
               "Mille-Iles: Francine Charbonneau (LIB) 35.8%",
               "Mirabel: Sylvie D’Amours (CAQ) 54.6%",
               "Montarville: Nathalie Roy (CAQ) 41.1%",
               "Montmorency: Jean-Francois Simard (CAQ) 51.2%",
               "Mont-Royal-Outremont: Pierre Arcand (LIB) 51.3%",
               "Nelligan: Monsef Derraji (LIB) 65.1%",
               "Nicolet-Becancour: Donald Martel (CAQ) 55.3%",
               "Notre-Dame-de-Grace: Kathleen Weil (LIB) 63.0%",
               "Orford: Gilles Belanger (CAQ) 40.1%",
               "Papineau: Mathieu Lacombe (CAQ) 46.9%",
               "Pointe-aux-Trembles: Chantal Rouleau (CAQ) 39.0%",
               "Pontiac: Andre Fortin (LIB) 53.8%",
               "Portneuf: Vincent Caron (CAQ) 54.3%",
               "Prevost: Marguerite Blais (CAQ) 47.0%",
               "Rene-Levesque: Martin Ouellet (PQ) 42.2%",
               "Repentigny: Lise Lavallée (CAQ) 49.7%",
               "Richelieu: Jean-Bernard Emond (CAQ) 49.8%",
               "Richmond: Andre Bachand (CAQ) 39.7%",
               "Rimouski: Harold LeBel (PQ) 43.9%",
               "Riviere-du-Loup-Temiscouata: Denis Tardif (CAQ) 39.2%",
               "Robert-Baldwin: Carlos Leitao (LIB) 73.9%",
               "Roberval: Philippe Couillard (LIB) 42.5%",
               "Rosemont: Vincent Marissal (QS) 35.2%",
               "Rousseau: Louis-Charles Thouin (CAQ) 53.2%",
               "Rouyn-Noranda-Temiscaminque: Emilise Lessard-Therrien (QS) 32.1%",
               "Saint-Francois: Genevieve Hebert (CAQ) 34.7%",
               "Saint-Henri-Sainte-Anne: Dominique Anglade (LIB) 38.1%",
               "Saint-Hyacinthe: Chantal Soucy (CAQ) 52.0%",
               "Saint-Jean: Louis Lemieux (CAQ) 39.5%",
               "Saint-Jerome: Youri Chassin (CAQ) 43.7%",
               "Saint-Laurent: Marwah Rizqy (LIB) 61.8%",
               "Sainte-Marie-Sainte-Jacques: Manon Massé (QS) 49.3%",
               "Sainte-Rose: Christopher Skeete (CAQ) 36.9%",
               "Sanguinet: Danielle McCann (CAQ) 43.5%",
               "Sherbrooke: Christine Labrie (QS) 34.3%",
               "Soulanges: Marilyne Picard (CAQ) 39.2%",
               "Taillon: Lionel Carmant (CAQ) 33.8%",
               "Taschereau: Catherine Dorion (QS) 42.5%",
               "Terrebonne: Pierre Fitzgibbon (CAQ) 43.0%",
               "Trois-Rivieres: Jean Boulet (CAQ) 41.2%",
               "Ungava: Denis Lamothe (CAQ) 26.5%",
               "Vachon: Ian Lafreniere (CAQ) 43.6%",
               "Vanier-Les Rivieres: Mario Asselin (CAQ) 45.1%",
               "Vaudreuil: Marie-Claude Nichols (LIB) 39.9%",
               "Vercheres: Suzanne Dansereau (CAQ) 37.4%",
               "Verdun: Isabelle Melancon (LIB) 35.5%",
               "Viau: Frantz Benjamin (LIB) 46.6%",
               "Vimont: Jean Rousselle (LIB) 36.7%",
               "Westmount-Saint-Louis: Jennifer Maccarone (LIB) 66.7%")

qc_results <- data.frame(qc_string)

qc_results$party <- gsub("[\\(\\)]", "", regmatches(qc_string, gregexpr("\\(.*?\\)", qc_string)))

qc_results$vote_share <- str_extract(qc_string, "\\-*\\d+\\.*\\d*")

qc_results <- qc_results %>%
  separate(qc_string, c("riding", "b"), ":") %>%
  mutate(candidate = gsub("\\(.*","",b)) %>%
  select(-b)

qc_copy <- quebec_prov_ridings2018

ridings1 <- gsub("`|\\'", "", iconv(qc_copy$riding_name, to="ASCII//TRANSLIT")) %>%
  gsub('[\\^]', '', .) %>%
  unique()

qc_copy$riding <- gsub("`|\\'", "", iconv(qc_copy$riding_name, to="ASCII//TRANSLIT")) %>%
  gsub('[\\^]', '', .)

qc_results$riding[qc_results$riding == "Arthabasca"] <- "Arthabaska"
qc_results$riding[qc_results$riding == "D’Arcy McGee"] <- "DArcy-McGee"
qc_results$riding[qc_results$riding == "Gaspé"] <- "Gaspe"
qc_results$riding[qc_results$riding == "L’Assomption"] <- "LAssomption"
qc_results$riding[qc_results$riding == "Laviolette Saint-Maurice"] <- "Laviolette-Saint-Maurice"
qc_results$riding[qc_results$riding == "Rouyn-Noranda-Temiscaminque"] <- "Rouyn-Noranda-Temiscamingue"
qc_results$riding[qc_results$riding == "Sainte-Marie-Sainte-Jacques"] <- "Sainte-Marie-Saint-Jacques"

qc_copy <- left_join(qc_results, qc_copy)

qc_copy <- qc_copy %>%
  select(party, vote_share, candidate, riding_code, riding_name, RIDING_NAME)

quebec_provincial_results  <- unique(qc_copy[ , 1:6])

use_data(quebec_provincial_results, overwrite = TRUE)
