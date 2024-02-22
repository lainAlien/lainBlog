<html>
    <?php
        $archive_string = "";
        //build the tree out
        foreach( glob( "posts/*", GLOB_ONLYDIR ) as $year_dir ) {
            $archive_string .= "<button class='collapsible year'>" . substr( $year_dir, 6 ) . "</button>";
            $archive_string .= "<div class='content'>";
            foreach( glob( "$year_dir/*", GLOB_ONLYDIR ) as $month_dir ) {
                $archive_string .= "<button class='collapsible month'>" . substr( $month_dir, 11 ) . "</button>";
                $archive_string .= "<div class='content'>";
                foreach( glob( "$month_dir/*", GLOB_ONLYDIR ) as $day_dir ) {
                    $archive_string .= "<button class='collapsible day'>" . substr( $day_dir, 14 ) . "</button>";
                    $archive_string .= "<div class='content'>";
                    $archive_string .= "<ol>";
                    foreach( glob( "$day_dir/*.md" ) as $post_fname ) {
                        $archive_string .= "<li><a href='" . $day_dir . "/?post=" . substr( $post_fname, 17, -3 ) . "'>";
                        $archive_string .= str_replace( "_", "-", str_replace( "-", " ", substr( $post_fname, 20, -3 ) ) );
                        $archive_string .= "</a></li>";
                    }
                    $archive_string .= "</ol>";
                    $archive_string .= "</div>";
                }
                $archive_string .= "</div>";
            }
            $archive_string .= "</div>";
        }
    ?>

    <head>
        <link href="blog.css" rel="stylesheet"/>
    </head>
    <body>
        <h2>blog archive</h2>
        <br />
        <?php
            include "navbar.php";
            echo $archive_string;
        ?>

        <br />
        <script>
        var coll = document.getElementsByClassName("collapsible");
        var i;

        for (i = 0; i < coll.length; i++) {
        coll[i].addEventListener("click", function() {
            this.classList.toggle("active");
            var content = this.nextElementSibling;
            if (content.style.display === "block") {
            content.style.display = "none";
            } else {
            content.style.display = "block";
            }
        });
        }
        </script>
    </body>
</html>