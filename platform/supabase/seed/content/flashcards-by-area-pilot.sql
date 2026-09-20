-- Flashcard content bucketed by the real PRC board exam Area 1/2/3 split
-- (not the fine-grained question-bank topics) per Gabriel's direction:
-- flashcards don't need per-subject topic tagging the way MCQ questions do.
--
-- Since flashcards.topic_id is a required FK to public.topics, this creates
-- exactly three umbrella topics -- "Area 1", "Area 2", "Area 3" -- if they
-- don't already exist, and buckets every card under one of them by mock_area
-- (same Area 1/2/3 definition as supabase/patches/007_mock_exam_areas.sql).
-- Each umbrella topic is tagged with a representative exam_area_id (the
-- dominant TOS category for that Area) purely to satisfy the NOT NULL FK;
-- the field that actually matters for grouping is mock_area.
--
-- Card format: the description/definition/context is on the FRONT, and the
-- bare term (or formula) is the answer on the BACK -- a "guess the term"
-- style card.
--
-- Content is deliberately filtered to board-exam-level material only:
-- formulas, PRC/PAES/PNS standards, and specialized ABE distinctions --
-- general-knowledge trivia (e.g. "what does a barometer measure") is left
-- out even where the source transcription includes it.
--
-- Sourced from ABELE TOP 1/TRANSES/: Hydrology, Irrigation and Drainage,
-- AICS (Geoinformatics/GIS section only), Bioprocessing, and Engineering
-- Economy. Idempotent: each card is inserted only if an identical front
-- does not already exist under that Area topic.

DO $$
DECLARE
  v_area2_id uuid;
  v_area3_id uuid;
  v_exam_area_id uuid;
  v_cards text[][];
  v_card text[];
BEGIN
  -- ==========================================================================
  -- Area 2 (Land and Water Resources Engineering)
  -- ==========================================================================
  SELECT id INTO v_area2_id FROM public.topics WHERE name = 'Area 2';
  IF v_area2_id IS NULL THEN
    SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'LAND_WATER';
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Area 2', 'area_2') RETURNING id INTO v_area2_id;
  END IF;

  v_cards := ARRAY[
    -- Hydrology
    ARRAY['The continuous vertical and horizontal movement of water as vapor, liquid, or solid between the Earth''s surface, subsurface, atmosphere, and oceans.', 'Hydrologic cycle (water cycle)'],
    ARRAY['The process whereby liquid water is converted to water vapor from open surfaces such as soil and water bodies.', 'Evaporation'],
    ARRAY['The process of liquid water vaporization/removal contained in plant tissues to the atmosphere through the stomata.', 'Transpiration'],
    ARRAY['The vertical movement of water through the soil profile.', 'Percolation'],
    ARRAY['The lateral movement of water under gravity through permeable layers of soil.', 'Seepage'],
    ARRAY['The basic unit of hydrology; the area upstream of a point along a river where all water coming off, mainly from precipitation, drains toward that point (the outlet).', 'Watershed'],
    ARRAY['The boundary line along topographic ridges that separates two adjacent watersheds -- the highest elevation that drains to a stream.', 'Watershed divide'],
    ARRAY['The point where flow from the entire basin concentrates as outflow in the stream channel; also called the outlet or measuring point.', 'Concentration point'],
    ARRAY['Classify watershed size: small, medium, and large.', 'Small watershed: less than 250 km^2. Medium watershed: 250-2,500 km^2. Large watershed: greater than 2,500 km^2.'],
    ARRAY['Give the formula for drainage basin length (L) in terms of area (A).', 'L = 1.312 x A^0.568'],
    ARRAY['Give the formula for basin slope (S).', 'S = (EL1 - EL2) / L, where EL1 and EL2 are elevations and L is the distance along the principal flow path.'],
    ARRAY['Precipitation resulting from the differential heating of air masses near the ground surface, causing warmer air to rise.', 'Convective precipitation'],
    ARRAY['Precipitation resulting from the mechanical lifting of an air mass over mountain barriers.', 'Orographic precipitation'],
    ARRAY['Precipitation associated with the movement of air masses due to differences in barometric pressure, triggered by a low-pressure area.', 'Cyclonic precipitation'],
    ARRAY['Give the two processes by which precipitation forms.', 'Collision-coalescence process (liquid particles colliding and joining in warm clouds) and the ice crystal (Bergeron) process (occurs in cold clouds where temperature is well below freezing).'],
    ARRAY['A method of estimating average areal precipitation that assumes the rainfall in an area may be taken as similar to that recorded at the nearest gaging station.', 'Thiessen polygon method'],
    ARRAY['Give the Thiessen polygon method formula for average areal precipitation.', 'P = (A1p1 + A2p2 + ... + Anpn) / (A1 + A2 + ... + An), where Ai is the area of influence of each gauging station and pi is its recorded rainfall.'],
    ARRAY['Give the Weibull equation for recurrence interval, and what do its variables mean?', 'T = (n+1)/m, where T is the return period in years, n is the number of records, and m is the rank.'],
    ARRAY['A hydrologic process governed by chance, with the time series independent (not dependent on prior values).', 'Probabilistic process'],
    ARRAY['A hydrologic process governed by chance, with the time series dependent (values depend on prior values).', 'Stochastic process'],
    ARRAY['Give the basic streamflow equation relating discharge, area, and velocity.', 'Q = AV, where Q is discharge, A is cross-sectional area, and V is velocity.'],
    ARRAY['A stream that carries water a considerable portion of the time, but ceases to flow occasionally or seasonally when bed seepage and evapotranspiration exceed the available water supply.', 'Intermittent stream'],
    ARRAY['A stream channel that carries water only during and immediately after periods of rainfall or snowmelt.', 'Ephemeral stream'],
    ARRAY['Give the Kirpich formula for time of concentration (tc) with L in meters.', 'tc = 0.02 x L^0.77 x S^-0.385, where L is the flow length in meters and S is the slope.'],
    ARRAY['Give the rational method equation for peak discharge.', 'qp = CiA, where C is the runoff coefficient, i is rainfall intensity, and A is the drainage area.'],
    ARRAY['In flood routing, the effect of a flood wave entering a reservoir, where the peak of the outflow hydrograph becomes smaller than that of the inflow hydrograph.', 'Attenuation (reservoir routing)'],
    ARRAY['The change in the shape of a hydrograph as it travels down a channel.', 'Channel routing'],
    -- Irrigation and Drainage
    ARRAY['The amount of water a soil profile will hold against drainage by gravity at a specified time (usually 24 to 48 hours) after a thorough wetting; soil moisture tension at this point is normally between 1/10 to 1/3 atmosphere.', 'Field capacity'],
    ARRAY['The soil moisture content at which plants permanently wilt; soil moisture tension at this point is about 15 atmospheres.', 'Permanent wilting point'],
    ARRAY['The difference in soil moisture content between field capacity and the permanent wilting point.', 'Available moisture (AM)'],
    ARRAY['The portion of available moisture most easily extracted by plants -- approximately 75% of the available moisture.', 'Readily available moisture (RAM)'],
    ARRAY['Give the formula for readily available moisture (RAM).', 'RAM = 0.75(FC - PWP) x As x Drz, where FC is field capacity, PWP is permanent wilting point, As is apparent specific gravity, and Drz is root zone depth.'],
    ARRAY['Water tightly bound to soil particles by molecular forces; unavailable to plants.', 'Hygroscopic water'],
    ARRAY['Water held in the micropores of the soil by surface tension; the main source of water for plants.', 'Capillary water'],
    ARRAY['Water that drains freely through macropores under gravity; not available to plants because it drains too quickly.', 'Gravitational water'],
    ARRAY['Give the formula for volumetric moisture content (mcv).', 'mcv = Vw/VT = MCw x As, where Vw is volume of water, VT is total soil volume, MCw is moisture content on a dry-weight basis, and As is apparent specific gravity.'],
    ARRAY['Give the formula for bulk density.', 'Bulk density = Ws/VT = particle density x (1 - n), where Ws is dry weight of soil, VT is total soil volume, and n is porosity.'],
    ARRAY['Give the formula for porosity (n).', 'n = Vv/VT = 1 - (BD/PD), where Vv is void volume, VT is total volume, BD is bulk density, and PD is particle density.'],
    ARRAY['Apparent specific gravity vs. real specific gravity -- how do they differ?', 'Apparent specific gravity is the ratio of bulk density to the density of water (includes pore space); real specific gravity is the ratio of particle density to the density of water (soil particles alone, excluding pores).'],
    ARRAY['Give the Lewis-Kostiakov infiltration equation.', 'F = ct^alpha (cumulative infiltration); ft = dF/dt = alpha x c x t^(alpha-1) (instantaneous infiltration rate), where c and alpha are constants.'],
    ARRAY['Give Horton''s infiltration equation.', 'ft = fc + (f0 - fc)e^(-kt), where fc is the final/ultimate constant infiltration rate, f0 is the initial infiltration rate, and k is a decay constant.'],
    ARRAY['An irrigation system with relatively large service areas, managed by government agencies.', 'National Irrigation System (NIS)'],
    ARRAY['An irrigation system managed and operated by farmers'' or irrigators'' associations.', 'Communal Irrigation System (CIS)'],
    ARRAY['Pipes vertically set into the ground to abstract groundwater for irrigation, usually owned and operated by individual farmers.', 'Shallow Tubewell Irrigation System (STW)'],
    ARRAY['An irrigation method in which water is directed to the base of the plant through small orifices called emitters, discharging at 1 to 8 liters per hour.', 'Drip (trickle) irrigation'],
    ARRAY['An irrigation method in which water is supplied to level plots surrounded by dikes or levees, useful on fine-textured, low-permeability soils.', 'Level-border (basin) irrigation'],
    ARRAY['An irrigation method that divides the field into strips by ridges running down the slope, allowing water to advance down the strip in a thin sheet.', 'Border-strip flooding'],
    ARRAY['A variation of furrow irrigation that uses small rills for irrigating closely spaced crops such as small grains and pastures.', 'Corrugation irrigation'],
    ARRAY['Give the recommended maximum slope ranges for furrow, border, and basin irrigation.', 'Furrow: 0.05% to 3.0%. Border: 2.0% to 5.0%. Basin: 0.1% or less.'],
    ARRAY['Give the formula for water conveyance efficiency.', 'Water conveyance efficiency = water delivered / water from source (expressed in percent).'],
    ARRAY['Give the formula for water application efficiency.', 'Water application efficiency = water stored in the root zone / water delivered to the farm.'],
    ARRAY['Give the formula for irrigation water requirement (IWR).', 'IWR = CWR - ER, where CWR is crop water requirement and ER is effective rainfall.'],
    ARRAY['Give the formula for farm water requirement (FWR).', 'FWR = IWR / application efficiency = IWR + farm losses.'],
    ARRAY['Give the formula for leaching requirement (LR).', 'LR = Ddw / (Diw + Drw) = EC(iw+rw) / ECdw, where Ddw is depth of drainage water, Diw and Drw are depths of irrigation and rain water, and EC terms are electrical conductivities.'],
    ARRAY['The difference in elevation between the water surface at the source and the water surface at the discharge point in a pumping system.', 'Static head'],
    ARRAY['The sum of total static head, pressure head, velocity head, and friction head in a pumping system.', 'Total dynamic head'],
    ARRAY['In a pumped well, the difference in elevation between the groundwater table and the water surface at the well when pumping.', 'Drawdown'],
    ARRAY['Name the five types of emitters classified by pressure dissipation mechanism.', 'Long-path, tortuous-path, short-path, orifice, and vortex emitters.'],
    ARRAY['Give the discharge-pressure relationship for emitters and the exponent (x) for a fully-compensating emitter.', 'Q = Kd x H^x; for a fully-compensating emitter, x = 0 (discharge is constant regardless of pressure).'],
    ARRAY['A structure built across a river to raise the water level and divert streamflow into a canal.', 'Diversion dam'],
    ARRAY['A structure used to raise the upstream water level within a canal during periods of low discharge so water can reach the head gates of branching canals.', 'Check gate'],
    ARRAY['An open-channel flow-measuring structure that constricts flow and allows water to pass over its crest.', 'Weir'],
    ARRAY['An open-channel measuring structure with a wide, flat converging section that widens at the outlet end.', 'Parshall flume'],
    ARRAY['A subsurface drain layout in which laterals enter the submain from one side only, minimizing double drainage.', 'Gridiron layout'],
    ARRAY['A subsurface drain layout in which laterals join the submain from each side alternately, causing double drainage along the submain.', 'Herringbone pattern'],
    ARRAY['A surface drainage system used where depressions are too deep or large to eliminate by land leveling, with ditches meandering between low spots.', 'Random ditch system'],
    ARRAY['A surface drainage system resembling terracing, with ditches constructed across the slope following the topography.', 'Interception (cross-slope) system'],
    ARRAY['Give Hooghoudt''s equation for drain spacing (steady state).', 'L = sqrt[(4k1h^2 + 8k2dh) / q], where k1 and k2 are hydraulic conductivities of the unsaturated and saturated soil layers, d is the effective depth of pipe drains, h is water table height, and q is drainage rate.'],
    -- Geographic Information System (from AICS Transes -- Geoinformatics section)
    ARRAY['The science of obtaining information about the Earth''s surface without direct contact, typically through satellites or aerial sensors.', 'Remote Sensing (RS)'],
    ARRAY['Passive vs. active remote sensing -- what is the difference?', 'Passive sensing depends on a natural energy source (e.g., sunlight) and records reflected radiation. Active sensing uses an artificial energy source, where the sensor emits a pulse of energy that interacts with the target.'],
    ARRAY['Give the incident energy formula relating reflected, absorbed, and transmitted energy.', 'EI = ER + EA + ET, where EI is incident energy, ER is reflected energy, EA is absorbed energy, and ET is transmitted energy.'],
    ARRAY['How much detail an image can capture -- finer values correspond to a smaller ground area represented per pixel.', 'Spatial resolution'],
    ARRAY['The unique pattern of reflectance of different materials across various wavelengths of light.', 'Spectral signature'],
    ARRAY['Name six common satellite imagery types.', 'Optical, multispectral, hyperspectral, thermal infrared (TIR), synthetic aperture radar (SAR), and LiDAR.'],
    ARRAY['This active sensor emits microwave signals and measures the reflected energy; it can penetrate clouds and operate at night, making it ideal for all-weather monitoring.', 'Synthetic Aperture Radar (SAR)'],
    ARRAY['A computerized system designed to capture, store, manipulate, analyze, manage, and present all spatial or geographical data types.', 'Geographic Information System (GIS)'],
    ARRAY['Vector data vs. raster data in GIS -- what is the difference?', 'Vector data represents features as points, lines, and polygons. Raster data is made up of grid cells (pixels).'],
    ARRAY['The act of assigning physical location (spatial coordinates) to objects on the Earth''s surface.', 'Georeferencing'],
    ARRAY['Latitude vs. longitude -- how is each measured?', 'Latitude is the angular distance, in degrees/minutes/seconds, of a point north or south of the Equator. Longitude is the angular distance of a point east or west of the Prime (Greenwich) Meridian.'],
    ARRAY['Name the four properties of map projection.', 'Conformality (correct shapes), equidistance (correct distances), equivalence (correct areas/sizes), and azimuthality (correct direction).'],
    ARRAY['Mercator projection vs. UTM projection -- what is the key geometric difference?', 'The Mercator projection wraps the cylinder around the Equator (zero distortion at the Equator). The Universal Transverse Mercator (UTM) wraps the cylinder around the Poles (transverse), used as an international standard coordinate system.'],
    ARRAY['The international standard coordinate system that models the Earth as a spheroid (ellipsoid), adopted in 1984.', 'WGS 84 (World Geodetic System of 1984)'],
    ARRAY['Give four common GIS spatial analysis functions and what each does.', 'Buffer: creates a zone around features at a specified distance. Intersect: identifies overlapping areas between layers. Union: combines two datasets and retains all features/attributes. Clip: cuts one layer using the boundary of another.']
  ];

  FOREACH v_card SLICE 1 IN ARRAY v_cards LOOP
    IF NOT EXISTS (SELECT 1 FROM public.flashcards WHERE topic_id = v_area2_id AND front = v_card[1]) THEN
      INSERT INTO public.flashcards (topic_id, front, back, source, status)
      VALUES (v_area2_id, v_card[1], v_card[2], 'ABELE TOP 1/TRANSES/', 'draft');
    END IF;
  END LOOP;

  -- ==========================================================================
  -- Area 3 (Structures/Environment, Bioprocess, Project Mgmt/RDE, Fundamentals, Math)
  -- ==========================================================================
  SELECT id INTO v_area3_id FROM public.topics WHERE name = 'Area 3';
  IF v_area3_id IS NULL THEN
    SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'STRUCTURES_ENVIRONMENT';
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Area 3', 'area_3') RETURNING id INTO v_area3_id;
  END IF;

  v_cards := ARRAY[
    -- Bioprocessing (rice/corn post-production, PNS/PAES grain standards)
    ARRAY['Constant rate period vs. falling rate period in crop drying -- what is the difference?', 'Constant rate period: drying takes place from the surface of the grain similar to evaporation from a free water surface. Falling rate period: comes after the constant rate period, controlled largely by movement of moisture within the material to the surface by liquid diffusion.'],
    ARRAY['Give the Heat Utilization Factor (HUF) formula.', 'HUF = (T1 - T3) / (T2 - T1), where T1 is original dry bulb air temperature, T2 is temperature of air after heating, and T3 is dry bulb temperature of air exhausted from the dryer.'],
    ARRAY['Direct heater air drying vs. indirect heater air drying -- what is the difference?', 'In direct heater drying, products of combustion are forced through the product with the drying air (less expensive, more efficient fuel use). In indirect heater drying, the heat transfer surface is heated by burning fuel and drying air passes around it before reaching the product (more expensive, lower thermal efficiency).'],
    ARRAY['Name the five principles/steps of rice milling.', 'Cleaning, dehusking and husk separation, paddy separation, bran removal, and grading.'],
    ARRAY['Name the three types of paddy separators and what property each exploits.', 'Compartment-type separator: difference in specific gravity and buoyancy. Tray-type separator: difference in specific gravity and length. Seven-type separator: difference in width and thickness.'],
    ARRAY['Abrasion process vs. friction process for bran removal -- what is the difference?', 'Abrasion process uses a rough surface (abrasive stone) to break and peel the bran off the grain. Friction process uses the friction between grains themselves to break and peel off the bran.'],
    ARRAY['Whitening vs. polishing in rice milling -- what is the difference?', 'Whitening is the process of removing the outer (and sometimes inner) bran layer. Polishing is the process of removing small bran particles that stick to the rice surface after whitening, giving the rice grain a shiny appearance.'],
    ARRAY['Name four types of rice mills commonly available in the Philippines.', 'Kiskisan (friction-type, most popular in rural areas, 50-60% recovery), Cono-type rice mill (under-runner disc), centrifugal type (uses centrifugal force and impact), and rubber roll (friction-type using two rubber rolls at different speeds, ~70% milling recovery).'],
    ARRAY['Bag storage vs. bulk storage for grain -- name one advantage of each.', 'Bag storage: flexible, lower capital cost. Bulk storage: not labor intensive, easier to monitor insects/rodents/birds, easier to fumigate.'],
    ARRAY['Wood frames used on concrete floors for stacking bags of rice, preventing direct contact between the grain and the floor and moisture migration.', 'Dunnage'],
    ARRAY['Weakening of tissues and increased susceptibility to disease infection that results from storing a commodity at low temperature above freezing when it is susceptible to physiological injury from that temperature.', 'Chilling injury'],
    ARRAY['The combining of carbohydrates in plant cells with the oxygen of the air to form carbon dioxide and water and to release energy, mostly as heat.', 'Respiration'],
    ARRAY['Give the formula for moisture content on a wet basis.', '%MCwb = [Ww / (Ww + Wd)] x 100%, where Ww is weight of water in the product and Wd is weight of dry matter.'],
    ARRAY['Give the formula for moisture content on a dry basis.', '%MCdb = (Ww / Wd) x 100%, where Ww is weight of water in the product and Wd is weight of dry matter.'],
    ARRAY['A group of highly poisonous and carcinogenic compounds produced by molds or fungi such as Aspergillus flavus on substrates like corn, peanuts, coconuts, oilseeds, and cassava; expressed in parts per billion (ppb).', 'Aflatoxin'],
    ARRAY['Brown/cargo rice vs. milled rice -- what is the difference?', 'Brown (cargo) rice is rice after only the husk has been removed. Milled rice is grain obtained after removal of both hull and bran.'],
    ARRAY['Define total milling recovery and head grain recovery.', 'Total milling recovery: weight of rice obtained in a milling operation expressed as a percentage of the original paddy weight. Head grain recovery: weight of head rice obtained expressed as a percentage of the original paddy weight.'],
    ARRAY['A grain or piece of grain with its length equal to or greater than 8/10th of the average length of the unbroken grain (PNS/PAES 206:2000).', 'Head rice'],
    ARRAY['Broken rice vs. brewer''s rice -- how are they classified by size?', 'Broken rice: milled rice whose size ranges less than 3/4 to 1/4 of a whole grain. Brewer''s rice (binlid): broken milled rice small enough to pass through a 1/16-inch sieve.'],
    ARRAY['Classify palay grain length: short, medium, and long grain.', 'Short grain: average brown rice length below 5.5 mm. Medium grain: 5.5 to 6.5 mm. Long grain: above 6.5 mm.'],
    ARRAY['Grade No. 1, 2, and 3 for rice and corn -- how do they rank?', 'Grade No. 1 meets the second highest grade requirements. Grade No. 2 is lower quality than Grade No. 1 but higher than Grade No. 3. Grade No. 3 meets only the lowest grade requirements. (Premium Grade is the highest.)'],
    ARRAY['Foreign matter (impurities such as weed, seeds, stones, sand, and dirt) found in rice.', 'Dockage'],
    ARRAY['Fancy palay vs. traditional variety -- what is the difference?', 'Fancy palay varieties possess special genetic characteristics in color, aroma, flavor, and cooking/eating qualities that distinguish them from other varieties. Traditional variety includes all indigenous or native varieties not included in the fancy classification.'],
    -- Engineering Economy (interest, annuity, depreciation, feasibility formulas)
    ARRAY['Give the formula for ordinary simple interest.', 'I = Pin; F = P(1 + in), where F is future worth, P is principal, i is interest rate per period, and n is number of interest periods.'],
    ARRAY['Give the discrete compound interest formula.', 'F = P(1 + i)^n, where F is future worth, P is principal, i is interest rate per period, and n is the number of compounding periods.'],
    ARRAY['Give the continuous compounding formula.', 'F = Pe^(rn), where P is principal, r is the nominal annual rate, and n is time in years.'],
    ARRAY['Give the formula for effective rate of interest given the nominal rate.', 'ie = (1 + i)^m - 1 for discrete compounding, or ie = e^r - 1 for continuous compounding.'],
    ARRAY['Give the formula converting a discount rate (d) to an equivalent interest rate (i), and vice versa.', 'd = i/(1+i), and i = d/(1-d).'],
    ARRAY['Name the four essential elements of an ordinary annuity.', '1) All payments are equal in amount. 2) Payments are made at equal intervals of time. 3) The first payment is made at the end of the first period, and all subsequent payments at the end of each corresponding period. 4) Compound interest is paid on all amounts in the annuity.'],
    ARRAY['Give the uniform series present worth factor formula (P/A, i, n).', 'P = A[((1+i)^n - 1) / (i(1+i)^n)]'],
    ARRAY['Give the capital recovery factor formula (A/P, i, n).', 'A = P[(i(1+i)^n) / ((1+i)^n - 1)]'],
    ARRAY['Give the sinking fund factor formula (A/F, i, n).', 'A = F[i / ((1+i)^n - 1)]'],
    ARRAY['What is the decision rule for Internal Rate of Return (IRR) on a single project?', 'The project is acceptable if IRR is greater than or equal to the Minimum Attractive Rate of Return (MARR).'],
    ARRAY['The interest rate that makes the Net Present Value (NPV) of a project equal to zero.', 'Internal Rate of Return (IRR)'],
    ARRAY['Give the benefit-cost ratio (BCR) formula, and state the decision rule.', 'BCR = (Benefits - Disbenefits) / Cost. If BCR > 1, the project is economically justified.'],
    ARRAY['Give the formula for Return on Investment (ROI).', 'ROI (%) = Net Profit / Total Investment'],
    ARRAY['Name the three requirements for a property to be depreciable.', '1) It must be used in business or held for the production of income. 2) It must have a determinable life longer than one year. 3) It must be something that wears out, decays, gets used up, becomes obsolete, or loses value from a natural cause.'],
    ARRAY['Give the straight-line depreciation formula.', 'd = (Co - Cn) / n, where Co is original cost, Cn is salvage/scrap value, and n is useful life in years.'],
    ARRAY['Give the Sum-of-Years''-Digits (SYD) formula.', 'SYD = n(n+1)/2, where n is useful life; the depreciation charge for a year = (remaining useful life / SYD) x depreciable basis.'],
    ARRAY['Declining balance (Matheson formula) method of depreciation -- give the formula for the rate k.', 'k = 1 - (Cn/Co)^(1/n), where Co is original cost, Cn is book value at end of life n.'],
    ARRAY['Book value vs. market value vs. salvage value -- how do they differ?', 'Book value is the worth of a property as shown on accounting records after depreciation. Market value is the amount a willing buyer would pay a willing seller. Salvage value is the second-hand/resale value of the equipment.'],
    ARRAY['The level of production/sales at which total revenue equals total cost (zero profit).', 'Break-even point'],
    ARRAY['A reasonable rate of return established for the evaluation and selection of investment alternatives.', 'Minimum Attractive Rate of Return (MARR)'],
    ARRAY['The equivalent annual cost of an investment, including a return on that investment.', 'Capital recovery']
  ];

  FOREACH v_card SLICE 1 IN ARRAY v_cards LOOP
    IF NOT EXISTS (SELECT 1 FROM public.flashcards WHERE topic_id = v_area3_id AND front = v_card[1]) THEN
      INSERT INTO public.flashcards (topic_id, front, back, source, status)
      VALUES (v_area3_id, v_card[1], v_card[2], 'ABELE TOP 1/TRANSES/', 'draft');
    END IF;
  END LOOP;

  RAISE NOTICE 'Flashcard pilot import complete for Area 2 and Area 3.';
END $$;
