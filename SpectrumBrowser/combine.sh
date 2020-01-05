(
  cd src/assets/css/components
  (
    for d in */ ; do
      echo "$d"
      cd "$d"
      rm -f -r colorStops
      rm -f -r dist
      rm -f index-lg.css
      rm -f index-vars.css
      rm -f package.json
      rm -f vars.css
      cat *.css */*.css > dist.css
      cd ..
    done

  )
)
