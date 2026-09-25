/**
 * Official title for each PAES standard number, keyed by the exact
 * `paes_reference` string stored on reviewer_entries/questions (e.g.
 * "PAES 401"). Verified against the actual transcribed source material for
 * each standard (either stated directly in a reviewer_entries.description,
 * or the standard's own source PDF filename under
 * "ABELE TOP 1/PAES/...") — never guessed from memory alone.
 *
 * Used by the PAES Library to show the real standard name as the section
 * header (e.g. "PAES 401 — Housing for Swine Production") instead of an
 * individual entry's own ad hoc title.
 */
// Individual reviewer_entries were transcribed with their own "PAES 402 —
// Table 3: ..." style title so they'd stand on their own in a flat list —
// but wherever the standard number is already shown separately (a group
// header, a floating reference badge), repeating "PAES 402 —" on every card
// is just noise. This strips that prefix (including a "(A)"-style subsection
// letter, e.g. "PAES 106 (A) — ...") so a card shows only the
// specification-level subtitle, e.g. "Table 3: Feeder length requirement".
const TITLE_PREFIX_RE = /^PAES\s+\d+[^—-]*[—-]\s*/;
export function stripPaesStandardPrefix(title: string): string {
  return title.replace(TITLE_PREFIX_RE, "").trim() || title;
}

// Groups a paes_reference into its official PAES numbering series (100s,
// 200s, ... 600s), which is the structure students actually recognize from
// the standards themselves — a subject-area label we invent ourselves
// (see paes-categories.ts) is a reasonable secondary lens for Mastery, but
// isn't how the Library's own top-level filter should be organized.
// "PNS BAFS PAES ###"-numbered standards (a later renumbering used for some
// equipment specifications) don't match the "PAES ###" pattern at all, so
// they fall into a distinct "PNS" bucket once that content exists.
export type PaesSeries = "PAES 100 Series" | "PAES 200 Series" | "PAES 300 Series" | "PAES 400 Series" | "PAES 500 Series" | "PAES 600 Series" | "PNS";

export const PAES_SERIES_ORDER: PaesSeries[] = [
  "PAES 100 Series",
  "PAES 200 Series",
  "PAES 300 Series",
  "PAES 400 Series",
  "PAES 500 Series",
  "PAES 600 Series",
  "PNS",
];

export function derivePaesSeries(paesReference: string): PaesSeries {
  const match = paesReference.match(/^PAES\s*(\d)\d{2}/i);
  if (!match) return "PNS";
  const hundreds = Number(match[1]);
  const series = `PAES ${hundreds}00 Series`;
  return (PAES_SERIES_ORDER as string[]).includes(series) ? (series as PaesSeries) : "PNS";
}

export const PAES_STANDARD_TITLES: Record<string, string> = {
  "PAES 101": "Agricultural Machinery — Technical Means for Ensuring Safety, General",
  "PAES 102": "Agricultural Machinery — Operator's Manual, Content and Presentation",
  "PAES 103": "Agricultural Machinery — Method of Sampling",
  "PAES 105": "Agricultural Machinery — Symbols for Operator's Controls and Other Displays, Common Symbols",
  "PAES 106": "Agricultural Machinery — Soil Tillage and Equipment, Terminology",
  "PAES 401": "Housing for Swine Production",
  "PAES 402": "Housing for Broiler Production",
  "PAES 403": "Housing for Layer Production",
  "PAES 404": "Housing for Goat and Sheep",
  "PAES 405": "Cattle Feedlot",
  "PAES 406": "Cattle Ranch",
  "PAES 407": "Housing for Dairy Cattle",
  "PAES 408": "Carabao Feedlot",
  "PAES 409": "Housing for Milking Parlor",
  "PAES 410": "Lairage for Swine, Small and Large Animals",
  "PAES 411": "Slaughterhouse for Swine, Small and Large Animals",
  "PAES 412": "Poultry Dressing Plant",
  "PAES 413": "Biogas Plant",
  "PAES 414": "Waste Management Structures (Agricultural Liquid and Solid Waste)",
  "PAES 415": "Greenhouse",
  "PAES 601": "General Irrigation Terminologies",
  "PAES 602": "Determination of Irrigation Water Requirements",
  "PAES 603": "Open Channels — Design of Main Canals, Laterals and Farm Ditches",
  "PAES 604": "Conveyance Systems — Performance Evaluation of Open Channels, Determination of Seepage",
  "PAES 605": "Conveyance Systems — Performance Evaluation of Open Channels, Determination of Conveyance",
  "PAES 606": "Design of Canal Structures — Road Crossing, Drop, Siphon and Elevated Flume",
  "PAES 607": "Design of Basin, Border and Furrow Irrigation Systems",
  "PAES 608": "Design of a Pressurized Irrigation System (Sprinkler / Drip Irrigation)",
  "PAES 609": "Rainwater and Runoff Management — Small Water Impounding System",
  "PAES 610": "Rainwater and Runoff Management — Small Farm Reservoir",
  "PAES 611": "Design of a Small Reservoir Irrigation System",
  "PAES 612": "Design of a Rockfill Dam",
  "PAES 613": "Design of a Diversion Dam",
  "PAES 614": "Design of a Check Dam",
  "PAES 615": "Groundwater Irrigation — Shallow Tubewell",
  "PAES 616": "Wastewater Re-use for Irrigation",
};
