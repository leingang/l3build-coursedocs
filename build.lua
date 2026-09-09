#!/usr/bin/env texlua

local function course_yml_field(field)
    local f = assert(io.open("course.yml", "r"))
    for line in f:lines() do
        local value = line:match("^%s*" .. field .. ":%s*\"?([^\"\n]-)\"?%s*$")
        if value then f:close(); return value end
    end
    f:close()
    error("Could not find '" .. field .. "' in course.yml")
end

bundle = course_yml_field("bundle_name")
maindir = "."
