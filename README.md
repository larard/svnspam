svnspam
=======

While it is still available, please go to
[the svnspam home](http://code.google.com/p/svnspam/) for complete documentation.

The intention of this fork is to save the version (it hasn't been updated since 2009), but also
to extend it so that we can get diffs even without having access to a subversion server.

Example line for post-commit (you have access to the subversion server) :
-------------------------------------------------------------------------
`
/opt/svnspam/svn_post_commit_hook.rb --config /opt/svnspam/svnspam.conf $*  >> /tmp/svnspam.log 2>&1
`

If you don't have access to the subversion server :
---------------------------------------------------
`
$ crontab -l
*/15 * * * * /path/to/svnspam/find_changes.sh > /tmp/svnspam.log 2>&1
`

Multiple repositories can be monitored by putting files in the svnspam/repositories/ directory.

