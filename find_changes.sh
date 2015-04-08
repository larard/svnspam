#!/bin/bash

#######
#  This script will look for any "helper" files that give us an SVN
#  repository along with the most recent SVN version that we know about.
#  It can take that information, determine the latest version that's
#  available, and call the svn_check_for_commits with a diff between the
#  two revisions.
#######

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
echo "Sending email to " ${send_to:="${USER}@rtlogic.com"}

for svn_file in `ls $base_dir/repositories/*`
do
    echo .....Working on $svn_file ....
    source $svn_file
    echo .....repository : $repository
    echo .....curr revision : $curr_revision

    latest_revision=`svn info $repository | egrep Revision | awk '{print $2}'`
    echo .....latest revision : $latest_revision

    if [ "$curr_revision" != "$latest_revision" ]
    then
        user_repo_name=$(basename $svn_file)
        $base_dir/svn_check_for_commits.rb $repository $latest_revision $curr_revision --config $base_dir/svnspam.conf --repository $user_repo_name --to $send_to
        echo last_run_time=\"`date`\" > $svn_file
        echo repository=\"$repository\" >> $svn_file
        echo curr_revision=\"$latest_revision\" >> $svn_file
    fi

done
