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
  "PAES 104": "Agricultural Machinery — Operator's Controls, Location and Method of Operation",
  "PAES 107": "Hitch for Walking-type Agricultural Tractor",
  "PAES 108": "Hexagonal Axle and Hub for Walking-type Agricultural Tractor",
  "PAES 109": "Walking-type Agricultural Tractor — Specifications, Part 1: Pull-type",
  "PAES 110": "Walking-type Agricultural Tractor — Specifications, Part 2: Rotary Tilling-type",
  "PAES 111": "Walking-type Agricultural Tractor — Methods of Test",
  "PAES 112": "Lever-operated Knapsack Sprayer",
  "PAES 113": "Lever-operated Knapsack Sprayer — Methods of Test",
  "PAES 114": "Centrifugal, Mixed-Flow and Axial-Flow Water Pumps",
  "PAES 115": "Centrifugal, Mixed-Flow and Axial-Flow Water Pumps — Methods of Test",
  "PAES 116": "Small Engine",
  "PAES 117": "Small Engine — Methods of Test",
  "PAES 118": "Four-Wheel Tractor",
  "PAES 119": "Four-Wheel Tractor — Methods of Test",
  "PAES 120": "Disc Harrow",
  "PAES 121": "Disc Plow",
  "PAES 122": "Seeder and Planter",
  "PAES 123": "Seeder and Planter — Methods of Test",
  "PAES 124": "Floating (Float-Assist) Tiller",
  "PAES 125": "Sprinkler Head",
  "PAES 126": "Rotating Sprinkler Head — Methods of Test",
  "PAES 127": "Drilling Rig",
  "PAES 128": "Drilling Rig — Methods of Test",
  "PAES 129": "Electric Motor",
  "PAES 130": "Electric Motor — Methods of Test",
  "PAES 131": "Moldboard Plow",
  "PAES 132": "Disc Plow and Moldboard Plow — Methods of Test",
  "PAES 133": "Disc Harrow — Methods of Test",
  "PAES 134": "Furrower",
  "PAES 135": "Furrower — Methods of Test",
  "PAES 136": "Agricultural Trailer",
  "PAES 137": "Agricultural Trailer — Methods of Test",
  "PAES 138": "After-Sales Service",
  "PAES 139": "Roll-Over Protective Structures (ROPS)",
  "PAES 140": "Roll-Over Protective Structures (ROPS) — Methods of Test",
  "PAES 141": "Weeder",
  "PAES 142": "Weeder — Methods of Test",
  "PAES 143": "Rice Drum Seeder",
  "PAES 144": "Rice Drum Seeder — Methods of Test",
  "PAES 145": "Fertilizer Applicator",
  "PAES 146": "Fertilizer Applicator — Methods of Test",
  "PAES 147": "Field Cultivator",
  "PAES 148": "Field Cultivator — Methods of Test",
  "PAES 149": "Subsoiler",
  "PAES 150": "Subsoiler — Methods of Test",
  "PAES 151": "Mechanical Rice Transplanter",
  "PAES 152": "Mechanical Rice Transplanter — Methods of Test",
  "PAES 153": "Hand Pump",
  "PAES 154": "Hand Pump — Methods of Test",
  "PAES 155": "Mist Blower",
  "PAES 156": "Mist Blower — Methods of Test",
  "PAES 157": "Power Sprayer for Mango",
  "PAES 158": "Power Sprayer for Mango — Methods of Test",
  "PAES 159": "Sugarcane Planter",
  "PAES 160": "Sugarcane Planter — Methods of Test",
  "PAES 161": "Soil Auger",
  "PAES 162": "Soil Auger — Methods of Test",
  "PAES 163": "Spring-tooth Harrow",
  "PAES 164": "Spring-tooth Harrow — Methods of Test",
  "PAES 165": "Granule Applicator",
  "PAES 166": "Granule Applicator — Methods of Test",
  "PAES 201": "Heated-Air Mechanical Grain Dryer",
  "PAES 202": "Heated-Air Mechanical Grain Dryer — Methods of Test",
  "PAES 203": "Moisture Content Determination for Rice and Corn",
  "PAES 204": "Mechanical Rice Thresher",
  "PAES 205": "Mechanical Rice Thresher — Methods of Test",
  "PAES 206": "Rice Mill",
  "PAES 207": "Rice Mill — Methods of Test",
  "PAES 208": "Power-Operated Corn Sheller",
  "PAES 209": "Power-Operated Corn Sheller — Methods of Test",
  "PAES 210": "Corn Mill",
  "PAES 211": "Corn Mill — Methods of Test",
  "PAES 212": "Rice Reaper",
  "PAES 213": "Rice Reaper — Methods of Test",
  "PAES 214": "Rubber Rolls for Rice Mill",
  "PAES 215": "Rubber Rolls for Rice Mill — Methods of Test",
  "PAES 216": "Hammer Mill",
  "PAES 217": "Hammer Mill — Methods of Test",
  "PAES 218": "Forage Chopper",
  "PAES 219": "Forage Chopper — Methods of Test",
  "PAES 220": "Peanut Sheller",
  "PAES 221": "Peanut Sheller — Methods of Test",
  "PAES 222": "Chipping Machine",
  "PAES 224": "Rice Combine",
  "PAES 226": "Micromill",
  "PAES 227": "Micromill — Methods of Test",
  "PAES 228": "Fiber Decorticator",
  "PAES 229": "Fiber Decorticator — Methods of Test",
  "PAES 230": "Coconut Oil Expeller",
  "PAES 231": "Coconut Oil Expeller — Methods of Test",
  "PAES 232": "Multicrop Washer-Peeler",
  "PAES 233": "Multicrop Washer-Peeler — Methods of Test",
  "PAES 234": "Multicrop Juice Extractor",
  "PAES 235": "Multicrop Juice Extractor — Methods of Test",
  "PAES 236": "Crystallizer",
  "PAES 237": "Crystallizer — Methods of Test",
  "PAES 238": "Multicrop Micromill",
  "PAES 239": "Multicrop Micromill — Methods of Test",
  "PAES 241": "Fans and Blowers",
  "PAES 243": "Biomass Furnace",
  "PAES 244": "Biomass Shredder",
  "PAES 245": "Biomass Shredder — Methods of Test",
  "PAES 246": "Dehusked Corn Dryer",
  "PAES 247": "Dehusked Corn Dryer — Methods of Test",
  "PAES 248": "Fruit Dryer",
  "PAES 249": "Fruit Dryer — Methods of Test",
  "PAES 250": "Coconut Coir Decorticator",
  "PAES 251": "Coconut Coir Decorticator — Methods of Test",
  "PAES 252": "Coffee Pulper",
  "PAES 253": "Coffee Pulper — Methods of Test",
  "PAES 254": "Abaca Stripper",
  "PAES 255": "Abaca Stripper — Methods of Test",
  "PAES 256": "Corn Picker",
  "PAES 258": "Feed Mixer",
  "PAES 259": "Feed Mixer — Methods of Test",
  "PAES 501": "Hog Restrainer",
  "PAES 502": "Hog Restrainer — Methods of Test",
  "PAES 503": "Hog Electric Stunner",
  "PAES 504": "Hog Electric Stunner — Methods of Test",
  "PAES 505": "Hog Scalder",
  "PAES 506": "Hog Scalder — Methods of Test",
  "PAES 507": "Dehairing Machine",
  "PAES 508": "Dehairing Machine — Methods of Test",
  "PAES 509": "Splitting Saw for Hog Carcass",
  "PAES 510": "Splitting Saw for Hog Carcass — Methods of Test",
  "PAES 511": "Overhead Rail System for Hogs",
  "PAES 512": "Overhead Rail System for Hogs — Methods of Test",
  "PAES 513": "Stunning Box or Knocking Pen",
  "PAES 515": "Captive Bolt",
  "PAES 516": "Captive Bolt — Methods of Test",
  "PAES 517": "Overhead Rail System for Large Ruminants",
  "PAES 518": "Overhead Rail System for Large Ruminants — Methods of Test",
  "PAES 519": "Dehider",
  "PAES 520": "Dehider — Methods of Test",
  "PAES 521": "Splitting Saw for Large Ruminants",
  "PAES 522": "Splitting Saw for Large Ruminants — Methods of Test",
  "PAES 523": "Platform",
  "PAES 524": "Platform — Methods of Test",
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
