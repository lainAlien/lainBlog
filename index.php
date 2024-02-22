<html>
    <?php include "parsedown/Parsedown.php";
        $Parsedown = new Parsedown();
        // get the latest post
        $year_dir = glob( "posts/*", GLOB_ONLYDIR );
        $latest_y = $year_dir[ count($year_dir) - 1 ];
        $month_dir = glob( "$latest_y/*", GLOB_ONLYDIR );
        $latest_m = $month_dir[ count($month_dir) - 1 ];
        $day_dir = glob( "$latest_m/*", GLOB_ONLYDIR );
        $latest_d = $day_dir[ count($day_dir) - 1 ];
        $post_dir = glob( "$latest_d/*.md" );
        $latest_post = $post_dir[ count($post_dir) - 1 ];
        // parse it down!
        $post_content = file_get_contents( $latest_post );
        $post_content = $Parsedown->text($post_content);
    ?>
    <head>
        <link href="blog.css" rel="stylesheet"/>
    </head>
    <body>
        <h2>bolg</h2>
        <br />
        <?php
            include "navbar.php";
            echo $post_content;
        ?>

    </body>
</html>