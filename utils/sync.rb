require 'find'
require 'rubygems'
require 'mysql'

FTP_ROOT = 'FTP_ROOT'
MYSQL_HOST='localhost'
MYSQL_USER='root'
MYSQL_PASSWORD=''
MYSQL_DB='redmine'
SVN_HOST='SVN_HOST'
SVN_USER='SVN_USER'
SVN_PASS='SVN_PASS'
SVN_COMMIT_MSG='images add by redmine image robot'

my = Mysql::new(MYSQL_HOST,MYSQL_USER,MYSQL_PASSWORD,MYSQL_DB)

system 'echo `date` '


def set_image_status(id)
  st = my.prepare("update images set status = 10 where id = ?")
  st.execute(id)
  st.close
end

def svn_cmd(path,svn_repo,svn_path)
  exec 'cd ' + path
  exec 'rm '+ path+ '/done'
  exec "svn --username " + SVN_USER + " --password " + SVN_PASS + " import -m '" + SVN_COMMIT_MSG + "' " + path + ' '+ SVN_HOST  + svn_repo + "/trunk/" + svn_path + '> ' + path + '/log.txt' 
end

def exec cmd
  system cmd
end


Find.find(FTP_ROOT){|path| 
  if File.directory?(path) && File.exists?(path+'/done')
    id =  path.split('/').last
    res = my.query('select svn_repo,svn_path from images where id = ' + id)
    if res.num_rows > 0
      row =  res.fetch_row()
      svn_cmd(path,row[0],row[1])
      st = my.prepare("update images set status = 10 where id = ?")
      st.execute(id)
      st.close
    else
      exec 'echo ' + id + ' not exist. >> ' + path + 'log.txt' 
    end
  end
}


my.close()
