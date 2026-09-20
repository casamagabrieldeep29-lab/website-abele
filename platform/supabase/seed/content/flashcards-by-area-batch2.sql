-- Second batch of flashcard content, same Area 1/2/3 bucketing convention as
-- flashcards-by-area-pilot.sql. Additive and independent of that file: it
-- looks up each Area topic by name (creating "Area 1" here for the first
-- time if needed) and only inserts cards that don't already exist under
-- that topic, so it's safe to run before, after, or without the first file.
--
-- Card format: description/definition/context on the FRONT, bare term or
-- formula on the BACK. Content filtered to board-exam-level material only.
--
-- Sourced from ABELE TOP 1/TRANSES/:
--   Area 1: Machinery and Mechanization, Marketing and Management, Power Eng
--   Area 2: Fluid Mechanics, Groundwater, Open Channel, Pump, Surveying
--   Area 3: Environmental Eng, Forest Eng, GMP HACCP

DO $$
DECLARE
  v_area1_id uuid;
  v_area2_id uuid;
  v_area3_id uuid;
  v_exam_area_id uuid;
  v_cards text[][];
  v_card text[];
BEGIN
  -- ==========================================================================
  -- Area 1 (Power/Energy/Machinery, Laws/Ethics)
  -- ==========================================================================
  SELECT id INTO v_area1_id FROM public.topics WHERE name = 'Area 1';
  IF v_area1_id IS NULL THEN
    SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'POWER_ENERGY_MACHINERY';
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Area 1', 'area_1') RETURNING id INTO v_area1_id;
  END IF;

  v_cards := ARRAY[
    -- Machinery and Mechanization: tillage, planting, harvesting, pumps, metals, welding, tractor drive
    ARRAY['Tillage equipment that performs the initial cutting, breaking, and inversion of soil to a depth of 6 to 36 inches; commonly called plowing.', 'Primary tillage'],
    ARRAY['Tillage equipment that further breaks, pulverizes, and levels the soil to prepare for planting, working to a depth of 3 to 6 inches; commonly called harrowing.', 'Secondary tillage'],
    ARRAY['The part of a moldboard plow that provides the cutting edge of the plow bottom.', 'Share'],
    ARRAY['The curved part of a moldboard plow that lifts and turns the furrow slice.', 'Moldboard'],
    ARRAY['The part of a moldboard plow that counteracts the side pressure exerted by the furrow slice.', 'Landside'],
    ARRAY['The base of the plow bottom to which other parts are attached.', 'Frog'],
    ARRAY['The trench or canal left by the furrow slice after plowing.', 'Furrow'],
    ARRAY['The raised ridge formed when two furrow slices overlap each other.', 'Backfurrow'],
    ARRAY['The trench left equal to two furrows when furrow slices are thrown on opposite sides.', 'Dead furrow'],
    ARRAY['The angle the disc makes with the vertical to make a disc plow penetrate the soil to the proper depth (15-25 degrees).', 'Tilt angle'],
    ARRAY['The angle the disc makes with the direction of travel to make a disc plow cut the proper width (42-45 degrees).', 'Disc angle'],
    ARRAY['Give the formula for draft horsepower (DHP).', 'DHP = F x S, where F is draft force and S is speed.'],
    ARRAY['A plowing method where the field is plowed in continuous circuits, starting from the center or outer edge of the field.', 'Round-about plowing'],
    ARRAY['A plowing method where the land is plowed in one direction only, suitable for hillside plowing.', 'One-way plowing'],
    ARRAY['In agricultural terminology, the strip of land cut or worked by a harvesting or tilling machine during one pass.', 'Swath'],
    ARRAY['Give the formula for the width of a tandem-type disc harrow.', 'W = 0.95NS + 1.2D, where N is number of disks, S is spacing, and D is disk diameter.'],
    ARRAY['A harrow consisting of long rigid spikes clamped or welded to cross bars in a staggered arrangement to attain maximum stirring and raking of the soil.', 'Spike-tooth harrow'],
    ARRAY['A tillage system that maintains a minimum of 30% residue cover on the soil surface after planting, or at least 1,100 kg/ha of flat small grain residue equivalent during the critical erosion period.', 'Conservation tillage'],
    ARRAY['A row-crop planter that plants seeds continuously in rows with row spacing greater than 36 cm.', 'Row-crop drill planter'],
    ARRAY['A planter designed to plant one seed or plant in rows and in hills, with precise spacing between hills.', 'Precision planter'],
    ARRAY['A planter designed to plant one or more seeds or plants with row spacing equal to hill spacing.', 'Checkrow planter'],
    ARRAY['The planter component that meters the seeds.', 'Metering device'],
    ARRAY['The planter component that deposits the seeds into the furrow.', 'Seed tube'],
    ARRAY['The planter component that makes a furrow.', 'Furrow opener'],
    ARRAY['Give the formula for Expected Plant Population (EPP).', 'EPP = [(10,000 m^2/ha)(seeds per hill)(emergence)] / (Row Spacing x Hill Spacing)'],
    ARRAY['Method of pest control that uses insects or repellent plants to manage pests.', 'Biological control'],
    ARRAY['Method of pest control involving breeding and planting pest-resistant crop varieties.', 'Physiological control'],
    ARRAY['Type of spray nozzle that produces a cone-shaped spray pattern (hollow or solid), best suited for crops as droplets approach leaves from several angles; operates at high pressure with a small orifice.', 'Cone type nozzle'],
    ARRAY['Type of spray nozzle that produces a flat spray pattern, best suited for spraying flat surfaces such as in herbicide application; operates at low pressure with a large orifice.', 'Fan type nozzle'],
    ARRAY['A pesticide application method using high-speed air to blow out liquid formed into small droplets of 50-100 micrometers, typically using a knapsack fog sprayer.', 'Mist spraying method'],
    ARRAY['A pesticide application method used for aviation spraying, using centrifugal force to scatter high-concentration pesticide into tiny droplets of 70-300 micrometers.', 'Ultra-low-volume (ULV) spraying method'],
    ARRAY['A pump type that discharges the same volume of fluid regardless of head pressure.', 'Positive displacement pump'],
    ARRAY['A pump type common for domestic and irrigation use, using centrifugal force with an impeller in a casing; has an inverse relationship between head and discharge.', 'Centrifugal pump'],
    ARRAY['A pump type with low head and high discharge, used for drainage and canal/river water transfer.', 'Propeller pump'],
    ARRAY['The theoretical maximum suction lift for a pump at sea level.', '33 feet (10.34 m)'],
    ARRAY['The value that sets the allowable suction limit for a pump, accounting for vapor pressure and losses.', 'Net Positive Suction Head (NPSH)'],
    ARRAY['In rice combine harvesters, the cleaning screen that vibrates 300-400 times per minute to separate grain from chaff.', 'Oscillating screen'],
    ARRAY['In rice combine harvesters, the rotating assembly with rasp bars or spikes that works with a stationary element to thresh the crop.', 'Threshing cylinder (drum)'],
    ARRAY['Threshing feed type in which straws pass through the threshing section, as in axial-flow threshers and US combines.', 'Throw-in feeding'],
    ARRAY['Threshing feed type in which straws do not pass through the threshing section, as in pedal threshers and Japanese combines.', 'Hold-on feeding'],
    ARRAY['Threshing direction in which the crop enters one end, circles the cylinder axially several times, and exits the other end, separating about 90% of grains from the straw at the cylinder.', 'Axial-flow threshing'],
    ARRAY['Threshing direction in which the crop passes between the cylinder and concave, exiting tangentially, separating about 60% of grains through the concave.', 'Tangential-flow threshing'],
    ARRAY['Cylinder tooth type with bar-like protrusions in parallel orientation, adopted for a wide variety of crops like peanut and other cereals because of its mild action.', 'Rasp-bar cylinder'],
    ARRAY['Mechanical property describing a material''s resistance to being pulled apart (ultimate strength).', 'Tensile strength'],
    ARRAY['Mechanical property describing the stress at 0.2% permanent elongation of a material.', 'Yield strength'],
    ARRAY['Mechanical property describing the extent of deformation a material undergoes before breaking.', 'Ductility'],
    ARRAY['Mechanical property describing a material''s resistance to penetration and deformation.', 'Hardness'],
    ARRAY['Mechanical property describing a material''s ability to be shaped or formed.', 'Malleability'],
    ARRAY['A welding process using oxygen and acetylene gas for fusion welding, with the oxygen cylinder tall and slim at 2,200 psi and the acetylene cylinder short and wide at about 250 psi.', 'Oxyacetylene welding'],
    ARRAY['A welding process that joins metals via electric current and pressure; its most common form is spot welding.', 'Resistance welding'],
    ARRAY['A welding process using high current to melt a flux-coated electrode, where the flux prevents oxidation and the electrode melts to provide filler material for the joint.', 'Arc welding'],
    ARRAY['A low-temperature (~427C) metal joining process mostly for non-ferrous metals, requiring clean metal surfaces and flux to remove oxidation, with no melting of the base metal.', 'Soldering'],
    ARRAY['A metal joining process using oxyacetylene equipment and a non-ferrous filler rod at temperatures above 427C but below the base metal''s melting point, using a common filler of 60% copper and 40% zinc (bronze) and borax powder as flux.', 'Brazing'],
    ARRAY['Give the formula for speed ratio in a chain-and-sprocket drive.', 'Speed Ratio = N1/N2 = T2/T1, where N is rpm and T is number of teeth.'],
    ARRAY['Give the formula for percent slippage of a tractor drive wheel.', '%Slippage = (Nunderload - Nno load) / Nunderload'],
    ARRAY['The type of clutch most common in tractors, using a coupler that utilizes friction between two surfaces pressed together to transmit power.', 'Friction clutch'],
    ARRAY['In series battery connection, what stays constant and what increases?', 'Voltage adds together (increases); current stays the same.'],
    ARRAY['In parallel battery connection, what stays constant and what increases?', 'Voltage stays the same; current capacity increases.'],
    ARRAY['Level of mechanization done solely with the use of mechanical power source with limited intervention by man.', 'Full mechanization'],
    ARRAY['Level of mechanization done with the use of nonmechanical power source (e.g., man/animal) in combination with a mechanical power source operated by man.', 'Intermediate mechanization'],
    -- Marketing and Management
    ARRAY['Management style where managers make all decisions and use threats for failure to comply.', 'Exploitive Authoritative (System 1) leadership'],
    ARRAY['Management style where group sets goals and makes decisions together, with motivation through rewards and recognition.', 'Participative (System 4) leadership'],
    ARRAY['Doing things right -- minimizing resources for maximum results.', 'Efficiency'],
    ARRAY['Doing the right things -- choosing the right actions to achieve success.', 'Effectiveness'],
    ARRAY['Farm risk-reduction method that spreads risk by investing in various crops or livestock instead of relying on one.', 'Diversification'],
    ARRAY['Farm risk-reduction method that locks in prices for future sales to mitigate market volatility.', 'Future contract'],
    ARRAY['Give the formula for the current (liquidity) ratio, and its ideal minimum value.', 'Current Ratio = Current Assets / Current Liabilities; ideal ratio is at least 2:1.'],
    ARRAY['Give the formula for the quick (acid-test) ratio, and its ideal minimum value.', 'Quick Ratio = (Current Assets - Inventories) / Current Liabilities; ideal ratio is at least 1:1.'],
    ARRAY['Give the formula for net working capital.', 'NWC = Current Assets - Current Liabilities'],
    ARRAY['Market segmentation based on age, gender, income, and education.', 'Demographic segmentation'],
    ARRAY['Market segmentation based on lifestyle, values, and personality.', 'Psychographic segmentation'],
    ARRAY['Give the formula for customer value in marketing.', 'Value = Benefits - Costs'],
    ARRAY['A broad promise of value a company offers to customers, focusing on all the benefits a customer receives.', 'Value proposition'],
    ARRAY['A specific feature or benefit that makes a product different or better than competitors.', 'Unique Selling Proposition (USP)'],
    ARRAY['Marketing philosophy that assumes customers prefer widely available, low-cost products ("make it cheap and make it available").', 'Production concept'],
    ARRAY['Marketing philosophy that believes customers won''t buy enough unless pushed to buy ("make them buy it").', 'Selling concept'],
    ARRAY['Marketing philosophy that starts with the customer, not the product ("find what they want, give it better than anyone else").', 'Marketing concept'],
    ARRAY['Market structure where one firm controls the market with no close substitutes and high barriers to entry (e.g., a local electricity provider).', 'Monopoly'],
    ARRAY['Market structure where few interdependent firms control the market, with moderate to high barriers to entry (e.g., telecom industry).', 'Oligopoly'],
    ARRAY['Market structure with many sellers offering differentiated (not identical) products and low barriers to entry (e.g., fast food chains).', 'Monopolistic competition'],
    ARRAY['Market structure with many small firms selling identical products, no barriers to entry or exit, where firms must accept the market price.', 'Perfect competition'],
    ARRAY['Type of demand where a decrease in price results in higher total revenue.', 'Elastic demand'],
    ARRAY['Type of demand where lowering prices results in revenue loss.', 'Inelastic demand'],
    ARRAY['Agricultural pricing strategy that sets low prices initially to gain market share (opposite of skim pricing).', 'Penetration pricing'],
    ARRAY['Agricultural pricing strategy that starts with high prices, then lowers them as competitors enter the market.', 'Skim (slim) pricing'],
    ARRAY['Illegal pricing practice involving collusion among competitors to set the same price for similar products.', 'Price fixing'],
    ARRAY['Illegal pricing practice of selling products internationally below cost.', 'Price dumping'],
    ARRAY['Marketing system participant that buys in bulk from producers and sells smaller quantities to retailers, without dealing with end-users.', 'Wholesaler'],
    ARRAY['Marketing system participant that facilitates transactions between producers and buyers, earning a commission, without owning the product.', 'Agent'],
    ARRAY['Marketing system participant that negotiates sales in larger markets without owning products.', 'Broker'],
    ARRAY['Utility created by processing that changes raw materials into more useful products (e.g., wheat to flour).', 'Form utility'],
    ARRAY['Utility created by transportation that moves products from areas of abundance to areas of need.', 'Place utility'],
    ARRAY['Utility created by storage that ensures product availability when needed.', 'Time utility'],
    ARRAY['Product classification for goods directly harvested from farms that do not pass higher levels of transformation.', 'Fresh products'],
    ARRAY['Agricultural products that have undergone a secondary level of transformation, usable by other industries/processors but not yet ready for final consumption.', 'Semi-processed products'],
    ARRAY['Grouping land holdings to operate as one farm with pooled resources.', 'Compact farming'],
    ARRAY['Growing more than one crop per year on the same land.', 'Multiple cropping'],
    ARRAY['Land whose productivity barely covers its cost of production.', 'Marginal land'],
    ARRAY['The cost of choosing one resource use over another, considering what is forgone.', 'Opportunity cost (alternative cost)'],
    -- Power Engineering
    ARRAY['Give the formula for piston displacement (Pd).', 'Pd = (pi*D^2/4)*L, where D is bore diameter and L is stroke length.'],
    ARRAY['Give the formula for compression ratio (Cr).', 'Cr = (PD + Cv)/Cv = Total Volume/Clearance Volume, where PD is piston displacement and Cv is clearance volume.'],
    ARRAY['Give the formula for camshaft RPM relative to crankshaft RPM in a 4-stroke engine.', 'Camshaft RPM = Crankshaft RPM / 2'],
    ARRAY['Give the standard firing order for a 6-cylinder in-line engine.', '1-5-3-6-2-4'],
    ARRAY['Give the formula for firing interval.', 'Firing Interval = (360 degrees x number of strokes) / number of cylinders'],
    ARRAY['Define indicated horsepower.', 'Power generated at the combustion chamber.'],
    ARRAY['Define brake horsepower.', 'Power available at the drive shaft or crankshaft of the engine.'],
    ARRAY['Define friction horsepower.', 'Power loss due to friction of the piston and other component parts of the machine.'],
    ARRAY['Give the formula for mechanical efficiency (ME).', 'ME = BHP/IHP'],
    ARRAY['Give the formula for brake horsepower (BHP) in terms of torque.', 'BHP = 2*pi*T*N, where T is torque and N is rotational speed.'],
    ARRAY['Give the formula for octane rating.', 'Octane Rating = Volume of Isooctane / Total Volume'],
    ARRAY['Give the formula for cetane rating.', 'Cetane Rating = (%N-cetane) + 0.15(%HMN)'],
    ARRAY['Which combustion property is important for diesel fuel (quick ignition), and which is important for gasoline (knocking resistance)?', 'Cetane number (diesel); Octane number (gasoline)'],
    ARRAY['Give the compression ratio ranges for spark ignition (SI) and compression ignition (CI) engines.', 'SI: 6-12. CI: 14-22.'],
    ARRAY['The temperature at which fuel vapors first ignite when exposed to a flame (lowest temperature).', 'Flash point'],
    ARRAY['The temperature at which fuel vapors continue burning after ignition.', 'Fire point'],
    ARRAY['The temperature at which fuel stops flowing.', 'Pour point'],
    ARRAY['A device that uses the engine''s exhaust gases to spin a turbine, which compresses air entering the engine.', 'Turbocharger'],
    ARRAY['An air compressor driven by the engine''s crankshaft (via belt, gear, or chain) to force more air into the engine.', 'Supercharger'],
    ARRAY['Give the formula for thermal efficiency (TE).', 'TE = Useful energy output / Energy provided by fuel'],
    ARRAY['Give the fixed value of the solar constant.', '1353 W/m^2'],
    ARRAY['The angle with which a ray of sunlight strikes the surface of a PV module, measured with respect to a line perpendicular to the surface.', 'Ray of incidence'],
    ARRAY['The tilt of a PV module with respect to the horizontal plane.', 'Angle of inclination'],
    ARRAY['Instrument that measures global solar radiation (both direct and diffuse).', 'Pyranometer'],
    ARRAY['Instrument that measures direct (beam) solar radiation only.', 'Pyrheliometer'],
    ARRAY['Solar radiation that travels in a straight line from the Sun to the surface without scattering.', 'Direct solar radiation (beam)'],
    ARRAY['Solar radiation redirected in multiple directions by molecules, aerosols, or clouds in the atmosphere.', 'Scattered radiation'],
    ARRAY['Wind turbine type: horizontal rotor shaft, highly efficient, common in wind farms.', 'Horizontal Axis Wind Turbine (HAWT)'],
    ARRAY['Wind turbine type: drag-based vertical axis turbine, good for turbulent wind.', 'Savonius turbine'],
    ARRAY['Wind turbine type: lift-based vertical axis turbine, efficient at higher wind speeds.', 'Darrieus turbine'],
    ARRAY['Classify hydropower plants by generated power: pico, micro, mini, small, medium, large.', 'Pico: P < 5kW. Micro: 5kW <= P <= 100kW. Mini: 100kW <= P <= 10MW. Small: 10MW <= P <= 25MW. Medium: 25MW <= P <= 100MW. Large: P > 100MW.'],
    ARRAY['A hydro turbine type that converts the entire pressure energy of the fluid into kinetic energy before striking the blades (e.g., the Pelton Wheel).', 'Impulse turbine'],
    ARRAY['A hydro turbine type that works on a gradual pressure drop as fluid flows through the blades, with both pressure and kinetic energy contributing to the output (e.g., the Francis turbine).', 'Reaction turbine'],
    ARRAY['A hydro turbine type used for small-scale power plants with low to medium heads, unique because water flows perpendicular (across) the turbine blades in two stages (e.g., the Banki-Michel turbine).', 'Cross-flow turbine'],
    ARRAY['The typical (average) efficiency of a hydro power plant.', '60%'],
    ARRAY['Give the maximum total power output a human can develop from the food eaten, and how much of that is available for useful work.', '0.5 hp total; only about 0.1 hp is available for useful work.'],
    ARRAY['Give the formula for weight of dung produced.', 'Weight of dung = manure available per animal per day x number of animals x number of days'],
    ARRAY['A lubrication method where oil is pumped under pressure through a network of oil passages directly to critical engine parts.', 'Force-fed lubrication'],
    ARRAY['A lubrication method where oil is picked up by a dipper and splashed onto moving parts, relying on mechanical movement and turbulence to distribute oil.', 'Splash lubrication'],
    ARRAY['The measure of a fluid''s resistance to flow, indicating its ability to separate moving surfaces in an engine.', 'Viscosity']
  ];

  FOREACH v_card SLICE 1 IN ARRAY v_cards LOOP
    IF NOT EXISTS (SELECT 1 FROM public.flashcards WHERE topic_id = v_area1_id AND front = v_card[1]) THEN
      INSERT INTO public.flashcards (topic_id, front, back, source, status)
      VALUES (v_area1_id, v_card[1], v_card[2], 'ABELE TOP 1/TRANSES/', 'draft');
    END IF;
  END LOOP;

  -- ==========================================================================
  -- Area 2 (Land and Water Resources Engineering)
  -- ==========================================================================
  SELECT id INTO v_area2_id FROM public.topics WHERE name = 'Area 2';
  IF v_area2_id IS NULL THEN
    SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'LAND_WATER';
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Area 2', 'area_2') RETURNING id INTO v_area2_id;
  END IF;

  v_cards := ARRAY[
    -- Fluid Mechanics
    ARRAY['Weight of fluid contained in a unit volume.', 'Unit weight (specific weight, gamma) = W/V = rho*g'],
    ARRAY['A dimensionless property equal to the ratio of a fluid''s density to that of water.', 'Specific gravity'],
    ARRAY['Frictional change in volume of a fluid per unit change in pressure in a constant-temperature process.', 'Compressibility (beta)'],
    ARRAY['Give the formula for Bulk Modulus of Elasticity (EB).', 'EB = -dp/(dV/V) = 1/beta'],
    ARRAY['Measure of a fluid''s resistance to shear, expressed in Pa-s or poise (1 poise = 0.1 Pa-s).', 'Dynamic (absolute) viscosity'],
    ARRAY['Ratio of absolute viscosity to density; expressed in m^2/s or Stoke (1 Stoke = 0.0001 m^2/s).', 'Kinematic viscosity'],
    ARRAY['State Pascal''s Law.', 'The pressure on a fluid is equal in all directions and in all parts of the container.'],
    ARRAY['Give the formula for energy contained in a fluid (pressure head).', 'h = P/gamma'],
    ARRAY['A gravity dam formed out of loose rock, earth, or a combination of these materials.', 'Embankment dam'],
    ARRAY['A concrete or masonry dam that curves upstream into the reservoir, stretching from one wall of a canyon to the other.', 'Arch dam'],
    ARRAY['A dam consisting of a wall or face supported by several structural supports on the downstream side.', 'Buttress dam'],
    ARRAY['Pressure under a gravity dam that produces an overturning effect.', 'Uplift pressure'],
    ARRAY['State Archimedes'' Principle (the law of hydrostatics).', 'Any body immersed in a fluid is acted upon by an upward (buoyant) force equal to the weight of the displaced fluid.'],
    ARRAY['Flow in which the discharge at every section of the stream is the same at any time (conservation of mass).', 'Continuous flow'],
    ARRAY['Flow in which the path of individual particles does not cross or intersect (Re < 2,000).', 'Laminar flow'],
    ARRAY['Flow in which the path of individual particles is irregular and continuously crosses (Re > 4,000).', 'Turbulent flow'],
    ARRAY['Give the continuity equation for incompressible fluids.', 'Q = A1v1 = A2v2 = A3v3 = constant'],
    ARRAY['State Bernoulli''s energy theorem.', 'Total head (velocity head + pressure head + elevation head) is constant along a streamline, per the conservation of energy.'],
    ARRAY['Give the Darcy equation, and what type of flow does it govern?', 'q = -(k/(mu*L))*deltaP; governs flow in aquifers and wells, applicable only for laminar flow.'],
    ARRAY['Give the Manning equation, and where is it applied?', 'V = (1/n)R^(2/3)*S^(1/2); applies to uniform flow in open channels.'],
    ARRAY['Give the Hagen-Poiseuille equation, and what does it calculate?', 'deltaP = 8*mu*L*Q/(pi*r^4); calculates the flow rate of a fluid through a pipe under laminar flow conditions.'],
    ARRAY['Dimensionless number representing the ratio of inertial to viscous forces within a fluid.', 'Reynolds number (Re)'],
    ARRAY['Dimensionless number relating the viscosity of a fluid to its thermal conductivity.', 'Prandtl number'],
    ARRAY['Ratio of convective to conductive heat transfer in a fluid system.', 'Nusselt number'],
    ARRAY['Dimensionless number representing the ratio of inertial to gravitational forces, describing flow regimes in open channels.', 'Froude number'],
    ARRAY['Give the Froude number thresholds for critical, supercritical, and subcritical flow.', 'Fr = 1: critical flow. Fr > 1: supercritical flow (fast, rapid). Fr < 1: subcritical flow (slow, tranquil).'],
    ARRAY['Instrument that measures the difference in pressure between two points.', 'Manometer'],
    ARRAY['Instrument used to measure the discharge (flow rate) of a fluid through a pipe by constriction and pressure difference.', 'Venturi meter'],
    ARRAY['A bent (L- or U-shaped) tube with both ends open, used to measure the velocity of fluid or air flow.', 'Pitot tube'],
    ARRAY['Instrument that measures the specific gravity (relative density) of a liquid.', 'Hydrometer'],
    ARRAY['Give the formula for actual discharge through a flow measurement device (with coefficient of discharge C).', 'Q = CA*sqrt(2gH)'],
    ARRAY['Give the relationship among the coefficient of discharge (C), coefficient of velocity (Cv), and coefficient of contraction (Cc).', 'C = Cc x Cv'],
    ARRAY['An in-line structure with a geometrically specified constriction built in an open channel to measure flow, with its centerline coinciding with the channel''s centerline.', 'Flume'],
    ARRAY['Give the Francis weir formula (rectangular, no contraction).', 'Q = 1.84LH^(3/2)'],
    ARRAY['Give the triangular (90-degree V-notch) weir formula.', 'Q = 1.38H^(5/2)'],
    ARRAY['The velocity below which all turbulence in pipe flow is damped out by fluid viscosity, represented by a Reynolds number of 2000.', 'Critical velocity'],
    ARRAY['Give the Darcy-Weisbach formula for head loss due to friction in a pipe.', 'hf = (fL/D)(v^2/2g), where f is the friction factor, L is pipe length, D is pipe diameter, and v is flow velocity.'],
    ARRAY['Give the friction factor formula for laminar flow (Re < 2000) in the Darcy-Weisbach equation.', 'f = 64/Re'],
    -- Groundwater
    ARRAY['A porous geologic formation capable of storing and transmitting water in sufficient quantities to permit economic development (e.g., unconsolidated sand and gravel).', 'Aquifer'],
    ARRAY['A geologic formation that can absorb water but cannot transmit significant amounts (e.g., clay).', 'Aquiclude'],
    ARRAY['A geologic formation of rather impervious nature that transmits water at a slow rate compared to an aquifer, insufficient for pumping (e.g., sandy clay).', 'Aquitard'],
    ARRAY['A geologic formation with no interconnected pores, which can neither absorb nor transmit water (e.g., compact rocks).', 'Aquifuge'],
    ARRAY['An aquifer just beneath the water table, not confined by a stratum under pressure higher than atmospheric; also called a ''water table aquifer.''', 'Unconfined aquifer'],
    ARRAY['An aquifer in which groundwater is confined under pressure greater than atmospheric by an overlying impermeable stratum; also called an ''artesian aquifer.''', 'Confined aquifer'],
    ARRAY['A special case of unconfined aquifer where a groundwater body is separated from the main groundwater by a relatively impermeable stratum of small areal extent and by the zone of aeration above.', 'Perched aquifer'],
    ARRAY['The imaginary line that coincides with the hydrostatic pressure level of water in a confined aquifer, defining the water level in a well drilled into it; also called the ''potentiometric surface.''', 'Piezometric surface'],
    ARRAY['A well drilled into a confined (artesian) aquifer where the ground surface is lower than the piezometric surface, allowing water to flow freely without pumping.', 'Flowing artesian well'],
    ARRAY['Layers where the soil is partially occupied by water and partially by air; also known as the ''vadose zone.''', 'Zone of aeration'],
    ARRAY['The zone extending from the water table to the capillary rise of water due to capillary forces; also called the ''capillary fringe.''', 'Capillary zone'],
    ARRAY['The amount of pore space per unit volume of an aquifer.', 'Porosity (n)'],
    ARRAY['The actual volume of water that can be extracted by gravity from a unit volume of aquifer; also called ''effective porosity.''', 'Specific yield (Sy)'],
    ARRAY['The fraction of water held back in the aquifer at field capacity.', 'Specific retention (Sr)'],
    ARRAY['The volume of water released from storage from a unit volume of aquifer due to a unit decrease in piezometric head.', 'Specific storage (Ss)'],
    ARRAY['The discharge per unit drawdown in a well.', 'Specific capacity'],
    ARRAY['The volume of water that can be stored in or released from an aquifer per unit decline in head.', 'Storage coefficient (storativity)'],
    ARRAY['Also called ''hydraulic conductivity''; combines the effects of the porous medium and fluid properties, having units of velocity, determined through a permeameter.', 'Coefficient of permeability (K)'],
    ARRAY['The discharge through an aquifer of unit width and thickness under a unit hydraulic gradient.', 'Transmissibility (transmissivity, T)'],
    ARRAY['Give the formula for transmissivity of a confined aquifer.', 'T = Kb, where K is hydraulic conductivity and b is the thickness of the confined aquifer.'],
    ARRAY['State Darcy''s Law.', 'The velocity of flow in a porous medium is proportional to the hydraulic gradient: V = Ki, where K is the coefficient of permeability and i is the hydraulic gradient.'],
    ARRAY['Give Darcy''s equation for discharge (Q).', 'Q = -KA(dh/dl), where K is hydraulic conductivity, A is cross-sectional area, and dh/dl is the hydraulic gradient.'],
    ARRAY['The slope of the water level or piezometric level -- the change in water level per unit distance along a maximum head decrease.', 'Hydraulic gradient (i)'],
    ARRAY['Darcy''s law is valid only for this type of flow, where velocity is proportional to the first power of the hydraulic gradient (Poiseuille''s Law), generally at a Reynolds number less than or equal to 1.', 'Laminar flow'],
    ARRAY['The variation of drawdown with distance from a well, describing the shape of the drawdown curve; also called the ''cone of depression.''', 'Drawdown curve'],
    ARRAY['The area from the outer limit of the cone of depression (zero drawdown) to the well.', 'Area of influence of a well'],
    ARRAY['Give the discharge formula for steady radial flow to a well in an unconfined aquifer.', 'Q = [pi*k(h2^2 - h1^2)] / ln(r2/r1), where k is hydraulic conductivity, h1 and h2 are piezometric heads at radial distances r1 and r2.'],
    ARRAY['Give the Hooghoudt equation for steady-state drain discharge.', 'q = R = 4K(H^2 - D^2)/L^2, where K is hydraulic conductivity, H and D are water levels relative to the drain, and L is drain spacing.'],
    ARRAY['An equation for groundwater flow to drainage systems, particularly in layered soils, that divides total hydraulic head loss into vertical, horizontal, and radial flow components.', 'Ernst equation'],
    ARRAY['Give the formula for total dynamic head (TDH) in well pumping.', 'TDH = SWL + Hf + DD + Hsf, where SWL is static water level, Hf is friction losses, DD is maximum drawdown, and Hsf is other head losses.'],
    ARRAY['Give the brake horsepower (BHP) formula for a pump.', 'BHP = (TDH x Qd) / (102 x Ep), where TDH is total dynamic head, Qd is design pump discharge, and Ep is pump efficiency.'],
    ARRAY['A shallow well constructed by the cutting action of a downward-directed stream of water to excavate the hole and carry out excavated materials.', 'Jetted well'],
    ARRAY['A shallow well used in unconsolidated formations with large diameters, permitting considerable water storage.', 'Dug well'],
    ARRAY['Concentrated discharge of groundwater appearing at the ground surface as a current of flowing water.', 'Spring'],
    ARRAY['A spring formed where the ground surface intersects the water table.', 'Depression spring'],
    ARRAY['A spring created by a permeable water-bearing formation overlying a less permeable formation that intersects the ground surface.', 'Contact spring'],
    ARRAY['A spring resulting from releases of water under pressure from confined aquifers, either at an outcrop of the aquifer or through an opening in the confining bed.', 'Artesian spring'],
    ARRAY['Per PAES 615:2016, what is the depth range and pipe diameter range for a Shallow Tube Well (STW)?', 'Depth of 6 to 20 meters; pipe diameter of 50 mm, 75 mm, or 100 mm.'],
    ARRAY['The pumping of water from a fully developed well at a controlled rate, observing the drawdown in two or more observation wells over time to determine aquifer hydrologic properties.', 'Pumping test'],
    -- Open Channel
    ARRAY['A waterway, canal, or conduit in which a liquid flows with a free surface.', 'Open channel'],
    ARRAY['A channel built with unvarying cross-section and constant bottom slope.', 'Prismatic channel'],
    ARRAY['Give the area formula for a trapezoidal open channel.', 'A = by + zy^2, where b is bottom width, y is depth of flow, and z is the side slope ratio.'],
    ARRAY['The vertical distance of the lowest point of a channel section from the free surface.', 'Depth of flow (y)'],
    ARRAY['The width of a channel section at the free surface.', 'Top width (T)'],
    ARRAY['The length of the line of intersection of the channel''s wetted surface with a cross-sectional plane normal to the flow direction.', 'Wetted perimeter (P)'],
    ARRAY['The ratio of the cross-sectional area of flow to the wetted perimeter.', 'Hydraulic radius (R)'],
    ARRAY['Give the formula for specific energy at a channel cross-section.', 'E = y + V^2/2g = y + Q^2/(2gA^2), where y is depth of flow and V is velocity.'],
    ARRAY['Give the critical-flow relationship between channel area, top width, discharge, and gravity.', 'A^3/T = Q^2/g'],
    ARRAY['A measuring device with a well-defined, sharp-edged opening in a wall through which flow occurs, with the upstream water level always well above the top of the opening.', 'Orifice'],
    ARRAY['Give the orifice discharge formula.', 'Q = CdAV, where Cd is the discharge coefficient (0.027-0.035 depending on orifice position), A is area, and V = sqrt(2gh).'],
    -- Pump
    ARRAY['A centrifugal pump type with a casing made in the form of a spiral or volute curve, converting velocity head to pressure head as fluid moves through the chamber.', 'Volute pump'],
    ARRAY['A centrifugal pump type where the impeller is surrounded by diffuser vanes that gradually reduce the velocity of water as it flows from the impeller to the discharge, converting velocity head to pressure head.', 'Diffuser pump (turbine pump)'],
    ARRAY['Impeller type designed to pump clear water only.', 'Enclosed impeller'],
    ARRAY['Impeller type that can pump water with a considerable amount of small solids.', 'Open impeller'],
    ARRAY['The act of filling up a pump with water to displace or evacuate entrapped air through a vent and create a liquid seal inside the casing.', 'Priming'],
    ARRAY['A pump priming method that develops a vacuum sufficient enough for atmospheric pressure to force liquid to flow through the suction pipe into the pump casing without priming.', 'Self-priming'],
    ARRAY['The vertical distance from the surface of the water to the eye of the impeller.', 'Static suction head'],
    ARRAY['The vertical distance or difference in elevation between the point at which water leaves the impeller and the point at which water leaves the system.', 'Static discharge head'],
    ARRAY['The rapid creation and subsequent collapse of air (vapor) bubbles in a fluid within a pump.', 'Cavitation'],
    ARRAY['Give the pump affinity law relating discharge (Q) to speed (N) at constant impeller diameter.', 'Q1/Q2 = N1/N2'],
    ARRAY['Give the pump affinity law relating head (H) to speed (N) at constant impeller diameter.', 'H1/H2 = (N1/N2)^2'],
    ARRAY['Give the pump affinity law relating brake horsepower (BHP) to speed (N) at constant impeller diameter.', 'BHP1/BHP2 = (N1/N2)^3'],
    ARRAY['Give the formula for pump efficiency in terms of water horsepower and brake horsepower.', 'Eff = WHP/BHP'],
    ARRAY['A graphical representation illustrating the relationship between a pump''s capacity, head, power, NPSH, and efficiency at a specific shaft speed.', 'Performance curve'],
    -- Surveying
    ARRAY['Type of surveying where the earth is considered a flat surface, used for surveys of limited extent.', 'Plane surveying'],
    ARRAY['Type of surveying where the earth is considered a spheroid, applicable to large areas and long lines.', 'Geodetic surveying'],
    ARRAY['Surveys made to map shorelines, chart the shape of areas underlying water surfaces, and measure the flow of streams, lakes, and other bodies of water.', 'Hydrographic surveys'],
    ARRAY['Industrial surveys known by this term, used for shipbuilding, aircraft assembly, and industries requiring very accurate dimensional layouts.', 'Optical tooling'],
    ARRAY['Surveys that determine alignment, grades, and earthwork quantities for highways, railroads, pipelines, and canals.', 'Route surveys'],
    ARRAY['A comparison of the measured quantity with a standard measuring unit using instruments.', 'Direct measurement'],
    ARRAY['The difference between the true value and the measured value of a quantity.', 'Error'],
    ARRAY['Inaccuracies in measurement caused by carelessness, inattention, poor judgment, or improper execution -- not classified as errors due to their large magnitude.', 'Mistakes (blunders)'],
    ARRAY['Errors that always have the same sign and magnitude under constant field conditions, following mathematical/physical laws, and can be computed and corrected.', 'Systematic errors (cumulative errors)'],
    ARRAY['Errors that occur by chance, can be positive or negative, and tend to cancel out or average by probability.', 'Accidental errors'],
    ARRAY['The degree of refinement and consistency with which a physical measurement is made, portrayed by the closeness of repeated measurements to one another.', 'Precision'],
    ARRAY['How close a given measurement is to the absolute or true value of the quantity measured.', 'Accuracy'],
    ARRAY['A quantity which, when added to or subtracted from the most probable value, defines a range within which there is a 50% chance the true value lies.', 'Probable error'],
    ARRAY['Give the formula for the probable error of a single measurement of a series.', 'PEs = +/-0.6745*sqrt[(sum of v^2)/(n-1)], where v is the residual and n is the number of observations.'],
    ARRAY['The ratio of the error to the measured quantity.', 'Relative error (relative precision)'],
    ARRAY['Give the total length and number of links of a Gunter''s chain.', '66 feet long, 100 links (each link is 0.66 ft or 7.92 inches).'],
    ARRAY['Give the total length of an Engineer''s chain, and the length of each link.', '100 feet long, 100 links, each link 1 foot.'],
    ARRAY['A metal alloy tape made of nickel (35%) and steel (65%), with a very low coefficient of thermal expansion, used for precise measurements.', 'Invar tape'],
    ARRAY['Give the slope taping formula relating horizontal distance (d) to slope distance (s) and angle of inclination.', 'd = s*cos(alpha)'],
    ARRAY['Give the formula for correction due to incorrect tape length.', 'Corr = TL - NL, where TL is true (actual) length of the tape and NL is nominal length of the tape.'],
    ARRAY['Give the formula for correction due to temperature in taping.', 'CT = alpha*L*(T - T0), where alpha is the coefficient of linear expansion, L is the length measured, T is observed temperature, and T0 is the standardized temperature.'],
    ARRAY['Give the formula for correction due to sag in taping.', 'Cs = w^2*L^3 / (24P^2), where w is weight of tape per unit length, L is unsupported length, and P is applied tension.'],
    ARRAY['An EDM instrument, an acronym for geodetic distance meter, developed by Erik Bergstrand in 1948, with a precision of 1/200,000.', 'Geodimeter'],
    ARRAY['The world''s second EDM instrument, using high-frequency microwave transmission capable of measuring distances up to 80 km day or night, with precision of 1/300,000.', 'Tellurometer'],
    ARRAY['A line which a plane passing through that point and the north and south poles intersects with the surface of the earth.', 'True meridian'],
    ARRAY['The direction shown by a freely floating and balanced magnetic needle free from all other attractive forces.', 'Magnetic meridian'],
    ARRAY['The acute horizontal angle between the reference meridian and the line.', 'Bearing'],
    ARRAY['The angle between the meridian and the line, measured in a clockwise direction from either the north or south branch of the meridian.', 'Azimuth'],
    ARRAY['The angle between adjacent lines in a closed polygon, measured as a re-entrant angle greater than 180 degrees.', 'Interior angle'],
    ARRAY['Leveling method that uses angles and distances (like solving a triangle) to find height difference; common in mapping and large-area surveys.', 'Trigonometric leveling (indirect leveling)'],
    ARRAY['Leveling method that uses a level instrument and staff to directly measure height difference; the most accurate and commonly used method.', 'Spirit leveling (direct leveling)'],
    ARRAY['A permanent reference point of known elevation used in leveling.', 'Bench mark'],
    ARRAY['An intervening point between two bench marks upon which foresight and backsight rod readings are taken to enable a leveling operation to continue from a new instrument position; also called a change point.', 'Turning point'],
    ARRAY['A reading taken on a rod held on a point of known or assumed elevation, referred to as a plus sight.', 'Backsight'],
    ARRAY['A reading taken on a rod held on a point whose elevation is to be determined, referred to as a minus sight.', 'Foresight'],
    ARRAY['Give the formula for height of instrument (HI) in differential leveling.', 'HI = Elevation + Backsight (BS)'],
    ARRAY['Give the formula for elevation of a point in differential leveling, using height of instrument.', 'Elevation = HI - Foresight (FS)'],
    ARRAY['A method of determining elevation differences between points by employing two level routes simultaneously.', 'Double-rodded differential leveling'],
    ARRAY['A more precise method of differential leveling wherein three horizontal hairs (or threads) are read and recorded rather than a single horizontal hair.', 'Three-wire leveling'],
    ARRAY['A leveling method ideal for determining large differences in elevation in rough or mountainous terrain, using an instrument that measures variations in atmospheric pressure.', 'Barometric leveling'],
    ARRAY['An instrument invented by Evangelista Torricelli that measures atmospheric pressure by the height of a column of mercury supported by the atmosphere (about 76 cm at sea level).', 'Mercurial barometer'],
    ARRAY['A precise aneroid barometer designed specifically for surveying applications.', 'Altimeter'],
    ARRAY['A series of lines of known lengths and magnetic bearings that forms a closed loop, or begins and ends at points of known position.', 'Closed compass traverse'],
    ARRAY['A precision surveying instrument used for measuring horizontal and vertical angles, and can also be used for trigonometric leveling and prolonging lines.', 'Theodolite'],
    ARRAY['A surveying instrument that combines a theodolite and an EDM, measuring angles, distances, and recording digital data.', 'Total station'],
    ARRAY['The distance between the upper and lower stadia hairs on a theodolite''s reticle, usually constant at 100 for a given instrument.', 'Stadia interval'],
    ARRAY['Give the stadia distance formula, and the typical value of the stadia interval factor k.', 'D = k x s, where k is the stadia constant (usually 100) and s is the difference between upper and lower stadia hair readings.'],
    ARRAY['A surveying method based on the optical geometry of instruments, also called tacheometry, used for indirect measurement of distance.', 'Stadia method']
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
    -- Environmental Engineering (EIA/ECC, climate agreements)
    ARRAY['A process that involves predicting and evaluating the likely impacts of a project, as well as ensuring preventive, mitigating, and enhancement measures to protect the environment and communities.', 'Environmental Impact Assessment (EIA)'],
    ARRAY['A decision document issued to a project proponent after a thorough review of the EIA Report, outlining the commitments necessary to comply with environmental regulations or best practice.', 'Environmental Compliance Certificate (ECC)'],
    ARRAY['A framework established under Article 12 of the Kyoto Protocol that allows developed countries to fund greenhouse gas emissions-reduction projects in developing countries, earning a Certified Emission Reduction (CER) for each ton of CO2 reduced.', 'Clean Development Mechanism (CDM)'],
    ARRAY['The first legally binding international agreement to reduce greenhouse gas emissions and combat global warming; created the CDM.', 'Kyoto Protocol'],
    ARRAY['The second update or extension of the Kyoto Protocol, establishing a second commitment period to reduce GHG emissions.', 'Doha Amendment'],
    ARRAY['The latest global climate agreement, adopted by 196 parties at COP21 in Paris on December 12, 2015, aiming to limit warming to 1.5C above pre-industrial (1990) levels.', 'Paris Agreement'],
    ARRAY['The state where CO2 emissions produced are balanced by an equivalent amount offset, typically through tree planting or renewable energy investment.', 'Carbon neutral'],
    ARRAY['Removing more CO2 from the atmosphere than is emitted, resulting in a net reduction of atmospheric CO2.', 'Carbon negative (climate positive)'],
    ARRAY['A measure of how much heat a greenhouse gas traps in the atmosphere compared to CO2 over a specific period of time (usually 100 years).', 'Global Warming Potential (GWP)'],
    -- Forest Engineering (logging, wood, engineered wood, seasoning)
    ARRAY['A selective cutting practice where only some trees are removed, usually the weaker, overcrowded, or less desirable ones.', 'Thinning'],
    ARRAY['A logging practice where all or most of the trees in a specific area are cut down at once.', 'Clearcutting'],
    ARRAY['A gymnosperm (cone-bearing tree) with simple cell structure, such as pine, spruce, or cedar.', 'Softwood'],
    ARRAY['An angiosperm (broadleaf tree) with vessels that make its wood structure more complex.', 'Hardwood'],
    ARRAY['Planed lumber having at least one smooth side; smooth on two sides is called S2S, smooth on four sides is called S4S.', 'Dressed lumber'],
    ARRAY['A piece of lumber 5 inches or larger in its smallest dimension.', 'Timber'],
    ARRAY['A wide piece of lumber from 4 to 5 inches thick.', 'Plank'],
    ARRAY['A piece of lumber less than 4 cm thick and at least 10 cm wide.', 'Board'],
    ARRAY['A thick, unprocessed piece of lumber or thick slab.', 'Flitch'],
    ARRAY['Rough lumber cut tangent to the annual ring.', 'Slab'],
    ARRAY['A radial crack originating from the heart of the tree.', 'Heart shakes'],
    ARRAY['Cracks or breaks across the annual rings of wood caused by wind pressure during growth.', 'Wind shake (cup shake)'],
    ARRAY['A wood defect that occurs at the starting point of a limb or branch.', 'Knot'],
    ARRAY['Engineered wood panel comprising thin layers of wood veneers glued together.', 'Plywood'],
    ARRAY['A low-density wood product made from chips, sawdust, and shavings.', 'Particle board'],
    ARRAY['A medium-to-high density wood panel made from fine wood fibers.', 'Fiberboard'],
    ARRAY['Engineered wood made by gluing layers of lumber to create stronger and larger pieces than solid wood.', 'Glue-laminated timber (Glulam)'],
    ARRAY['The process of removing excess moisture from freshly cut wood to prevent shrinking and warping, making it suitable for construction or furniture use.', 'Lumber seasoning'],
    ARRAY['A lumber-drying method where wood is stacked in open air with spacers to allow airflow; simple and cheap but slow (months to years).', 'Air drying'],
    ARRAY['A lumber-drying method using a kiln with controlled temperature, humidity, and air circulation; much faster (days to weeks) with uniform results.', 'Kiln drying'],
    -- GMP/HACCP/food process terms
    ARRAY['A system for ensuring that products are consistently produced and controlled according to quality standards, covering raw materials, facilities, and equipment.', 'Good Manufacturing Practices (GMP)'],
    ARRAY['Written steps for cleaning and sanitizing procedures necessary to ensure sanitary conditions in a food plant and prevent product adulteration.', 'Sanitation Standard Operating Procedures (SSOP)'],
    ARRAY['Systematic procedures for assessing the cleanliness and safety of the manufacturing environment by monitoring air, water, and surface contamination levels.', 'Environmental Monitoring Program (EMP)'],
    ARRAY['A systematic preventive approach to food safety that identifies physical, chemical, and biological hazards in production processes and designs measures to reduce these risks to safe levels.', 'Hazard Analysis and Critical Control Point (HACCP)'],
    ARRAY['Name the seven HACCP principles in order.', '1) Conduct a hazard analysis. 2) Determine the critical control points (CCPs). 3) Establish critical limits. 4) Establish monitoring procedures. 5) Establish corrective actions. 6) Establish verification procedures. 7) Establish record-keeping and documentation procedures.'],
    ARRAY['Heat treatment process involving rapid cooling of metal.', 'Quenching'],
    ARRAY['Heat treatment process that alters the mechanical properties of a material.', 'Tempering'],
    ARRAY['Heat treatment process that produces a wear-resistant surface on a material.', 'Case hardening'],
    ARRAY['A time-and-temperature-controlled heat treatment process used to relieve internal stresses in a material.', 'Annealing'],
    ARRAY['A process of heating food and beverages to a specific temperature for a set period to kill harmful microorganisms, preventing foodborne illnesses and extending shelf life.', 'Pasteurization'],
    ARRAY['A process that destroys or eliminates all forms of microbial life, including bacteria, viruses, fungi, and spores, through methods such as heat, chemicals, irradiation, or filtration.', 'Sterilization'],
    ARRAY['A process that uses ionizing radiation, such as gamma rays, X-rays, or electron beams, to treat food to kill harmful bacteria, molds, and insects without making the food radioactive.', 'Food irradiation']
  ];

  FOREACH v_card SLICE 1 IN ARRAY v_cards LOOP
    IF NOT EXISTS (SELECT 1 FROM public.flashcards WHERE topic_id = v_area3_id AND front = v_card[1]) THEN
      INSERT INTO public.flashcards (topic_id, front, back, source, status)
      VALUES (v_area3_id, v_card[1], v_card[2], 'ABELE TOP 1/TRANSES/', 'draft');
    END IF;
  END LOOP;

  RAISE NOTICE 'Flashcard batch 2 import complete for Area 1, Area 2, and Area 3.';
END $$;
