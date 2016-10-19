undef("wrf_regrid_inner_zone")
;; Get the wrf domain inner boundary of longitude and latitude
function wrf_regrid_inner_zone(lon2d, lat2d)
local dims, ny, nx, lonMin, lonMax, latMin, latMax
begin
    dims = dimsizes(lon2d)
    ny = dims(0)
    nx = dims(1)
    lonMin = max(lon2d(:, 0))
    lonMax = min(lon2d(:, nx-1))
    latMin = max(lat2d(0, :))
    latMax = min(lat2d(ny-1, :))
    return (/lonMin, lonMax, latMin, latMax/)
end

undef("wrf_regrid_outer_zone")
;; Get the wrf domain outer boundary of longitude and latitude
function wrf_interp_outer_zone(lon2d, lat2d)
local dims, ny, nx, lonMin, lonMax, latMin, latMax
begin
    dims = dimsizes(lon2d)
    ny = dims(0)
    nx = dims(1)
    lonMin = min(lon2d(:, 0))
    lonMax = max(lon2d(:, nx-1))
    latMin = min(lat2d(0, :))
    latMax = max(lat2d(ny-1, :))
    return (/lonMin, lonMax, latMin, latMax/)
end

undef("wrf_regrid_rectangle_latlon")
;; Generate a rectangle grid for regriding the wrf variable into
;; Input:
;;      lonLatMinMax, an array include four values
;;          lonMin, the minima longitude of wrf domain grid
;;          lonMax, the minima longitude of wrf domain grid
;;          latMin, the maxima latitude of wrf domain grid
;;          latMax, the maxima latitude of wrf domain grid
;; Output:
;;      lon, the longitude in equal-longitude rectangle
;;      lat, the latitude in equal-longitude rectangle
;; Note:
;;      Output is a list of lon and lat, to get each one of them, you must use list index,
;;      which like alist[0] (the longitude), alist[1] (the latitude)
function wrf_regrid_rectangle_latlon(lonLatMinMax, stardard_lat, resolution)
local length1DegLong, nxpoint, nypoint, lon, lat
begin
    PI = 3.1415926
    Deg2Rad = PI/180.
    EarthRadius = 6371008.8
    length1DegLat = 111000.
    length1DegLong = 2*PI*EarthRadius*cos(Deg2Rad*stardard_lat)/360.
    nxpoint = length1DegLong/resolution
    nypoint = length1DegLat/resolution
    lonMin = lonLatMinMax(0)
    lonMax = lonLatMinMax(1)
    latMin = lonLatMinMax(2)
    latMax = lonLatMinMax(3)
    lon = fspan(lonMin, lonMax, toint((lonMax-lonMin)*nxpoint))
    lat = fspan(latMin, latMax, toint((latMax-latMin)*nypoint))
    return [/lon, lat/]
end