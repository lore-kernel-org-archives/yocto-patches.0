Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C77FCCA490
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:49:03 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22358.1792360140846438852
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:49:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=MOOdaBdp;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06b27bf9bso51028b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792360140; x=1792964940; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GEBAL1aH6f3PS/QjPDV/zyDiSsBOUay2JlXlpSSeHtE=;
        b=MOOdaBdpUQCJLDqMa5Ldhy58AnjNtPSIOS6I88b23iuU0zkr8+9Ba55KPN1m9i6xOj
         b2gsufbW+/nKnAq4tJwlejcxX34kL3/hrTpCHZtIgfAcOGdW1M2+MtbrDlFodMdrut8Q
         JZYIK0WNBzpztoChjSNC9o1tJRd+Oa/rqbV56ZHkdS295SiZ4fSKo6qmhZyKCkxXlPy+
         bCRTWOED1EILyStYZJPhpcsgmpQ89yWUyH0/vZvLP41B0HXJBXaJ9yvcFg8jkM/oOIwe
         XCIU1ihtbA1jikkLz4y52CCIUDDZR1WQ14TBN44BkGk05S0uF6f9/5WkVFWfybkRN72J
         eEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360140; x=1792964940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GEBAL1aH6f3PS/QjPDV/zyDiSsBOUay2JlXlpSSeHtE=;
        b=p8jOyePIx+oaXdKChs6r2ItxSkLIXT3jRUJ4PIwfFbnBEeanfoHDuhGglNn+QcmYcz
         IngSmLjv3KkHHd+ydnbFJPTDJBHTgziRXQT446eF9/wNMlepuwujTXA372HapeZmHwMe
         krnqSz1LhrGZ6wo9PoaKdFWcb6vlcy56g/6G6Nhw9/LEyezjwP/wvDSImaUZhQg3XLmj
         aALPXnSlOARb4hXMF53STdknn4u166acasSUUEOwoVxUNs6J1eFXfVRzi60OAWHW8th0
         KLP5pRUsXwcKN3qD0UnBt8dtuLeTWln2GlZNgZPNg+mUm61wUCpwvMNomQIZu4A61e6B
         bNzA==
X-Gm-Message-State: AFq9FYIx1xm7JvKIijl/VwvHHOrFA7uxDMQj1i3v2+MTqL8+Ez+RHwRJ
	oXe5fXpK2oUfdyAHXALslTejYK7tZ0h25pIlY4wEs9H05xfURjA+iNhNQF8k2pNu
X-Gm-Gg: AYBFou0kEsq6XCBGnKGzwr2rqW/3y/+QwSz5EgGrpZPWQFhvCspGOO2E7K1vwkJ6DqA
	EsobaJubzR8hBkukNhLVamlLfZnsRvsV1j6Jjark+85gh/d1hVZFTh+qDf0zM/URRVk1Ssjz53X
	A+/ErCTMNs6jtxftyR9PN/5/sCDcKiWIbxMCX1Cqt2F5YMNIuMcAfayAvXJ5H6Zfo/WMrOQPPOp
	8/uJQogoEP+JO2Y+KZd8EFG9IT8RqnBFC3OihW/9Bn3khDiHnojI1qXrKe+pWChjRkylkeo6h+b
	lcelFs0cVNw3AuP2pUS/CfPGJkfyB4feMGssh2lT2Gkx8iM/yTwwghoLshUMSAT8na5dUGPRSaM
	fHv5W3gHRRZjl/yhUy7rnWaXl54J3/5l6MsJ0zW1i1JOkCtkCZUZ2xT57glW0E6Al5RMaaWHEcH
	1zIsuiaXMNe2hX1LFRZSHJSgN8Z3I1C8T25ptGyJ1jNC5aXzGnwij1XPs5SQbxBcYWgd4FGdB/L
	ef4uEVU+lwYBJpAHNAG7Cj6G9RhvvU=
X-Received: by 2002:a05:6a00:4107:b0:87c:f67f:f7d3 with SMTP id d2e1a72fcca58-8a0490d566bmr3778282b3a.0.1792360139860;
        Sun, 18 Oct 2026 14:48:59 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a04493551csm2010759b3a.44.2026.10.18.14.48.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:48:57 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/3] dockersetup.py: move the script body into main()
Date: Sun, 18 Oct 2026 14:48:45 -0700
Message-ID: <20261018214847.69431-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018214847.69431-1-tim.orling@konsulko.com>
References: <20261018214847.69431-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:49:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5078

The setup steps ran at module level, so importing dockersetup.py ran
the whole setup and none of its functions could be tested. Move them
into main(), called only when the file is run as a script, and move
the lookup of an existing installation's database root password into
read_db_root_password(). No change in behaviour.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 dockersetup.py | 523 +++++++++++++++++++++++++------------------------
 1 file changed, 266 insertions(+), 257 deletions(-)

diff --git a/dockersetup.py b/dockersetup.py
index bf4a814..e58cff2 100755
--- a/dockersetup.py
+++ b/dockersetup.py
@@ -631,84 +631,89 @@ def writefile(filename, data):
         f.write(data)
 
 
-## Get user arguments
-try:
-    args, socks_proxy_port, socks_proxy_host, email_host, email_port = get_args()
-except argparse.ArgumentTypeError as e:
-    print('error: %s' % e)
-    sys.exit(1)
-
-if args.update:
-    dbapassword = 'testingpw'
+# Read the database root password of an existing installation, from
+# .env.local.db or, for installations made before it existed, from
+# docker-compose.yml. Returns the development default if neither has one.
+def read_db_root_password():
     for filename in ('.env.local.db', 'docker-compose.yml'):
         if os.path.exists(filename):
             with open(filename, 'r') as f:
                 for line in f:
                     if 'MYSQL_ROOT_PASSWORD=' in line and not line.lstrip().startswith('#'):
-                        dbapassword = line.split('=')[1].rstrip().rstrip('"')
-                        break
-            if dbapassword != 'testingpw':
-                break
-    # Use last project name
+                        return line.split('=')[1].rstrip().rstrip('"')
+    return 'testingpw'
+
+
+def main():
+    ## Get user arguments
     try:
-        with open('.dockersetup-options', 'r') as f:
-            for line in f:
-                if line.startswith('project_name='):
-                    args.project_name = line.split('=', 1)[1].rstrip()
-    except FileNotFoundError:
-        pass
-else:
-    # Generate secret key and database password
-    secretkey = generatepasswords(50)
-    dbapassword = generatepasswords(10)
-    dbpassword = generatepasswords(10)
-    rmqpassword = generatepasswords(10)
-
-if args.project_name:
-    os.environ['COMPOSE_PROJECT_NAME'] = args.project_name
-else:
-    # Get the project name from the environment (so we can save it for a future upgrade)
-    args.project_name = os.environ.get('COMPOSE_PROJECT_NAME', '')
-
-https_port = None
-http_port = None
-if not args.update:
-    for portmap in args.portmapping.split(','):
-        outport, inport = portmap.split(':', 1)
-        if inport == '443':
-            https_port = outport
-        elif inport == '80':
-            http_port = outport
-    if (not https_port) and (not args.no_https):
-        print("No HTTPS port mapping (to port 443 inside the container) was specified and --no-https was not specified")
-        sys.exit(1)
-    if not http_port:
-        print("Port mapping must include a mapping to port 80 inside the container")
+        args, socks_proxy_port, socks_proxy_host, email_host, email_port = get_args()
+    except argparse.ArgumentTypeError as e:
+        print('error: %s' % e)
         sys.exit(1)
 
-## Check if it's installed
-installed = False
-return_code = subprocess.call("docker ps -a | grep -q layersapp", shell=True)
-if return_code == 0:
-    installed = True
+    if args.update:
+        dbapassword = read_db_root_password()
+        # Use last project name
+        try:
+            with open('.dockersetup-options', 'r') as f:
+                for line in f:
+                    if line.startswith('project_name='):
+                        args.project_name = line.split('=', 1)[1].rstrip()
+        except FileNotFoundError:
+            pass
+    else:
+        # Generate secret key and database password
+        secretkey = generatepasswords(50)
+        dbapassword = generatepasswords(10)
+        dbpassword = generatepasswords(10)
+        rmqpassword = generatepasswords(10)
+
+    if args.project_name:
+        os.environ['COMPOSE_PROJECT_NAME'] = args.project_name
+    else:
+        # Get the project name from the environment (so we can save it for a future upgrade)
+        args.project_name = os.environ.get('COMPOSE_PROJECT_NAME', '')
 
-if args.uninstall:
-    if not installed:
-        print("Cannot uninstall - application does not appear to be installed")
-        sys.exit(1)
-elif args.update:
-    if not installed:
-        print("Application container not found - update mode can only be used on an existing installation")
-        sys.exit(1)
-    if dbapassword == 'testingpw':
-        print("Update mode can only be used when previous configuration is still present in docker-compose.yml and other files")
+    https_port = None
+    http_port = None
+    if not args.update:
+        for portmap in args.portmapping.split(','):
+            outport, inport = portmap.split(':', 1)
+            if inport == '443':
+                https_port = outport
+            elif inport == '80':
+                http_port = outport
+        if (not https_port) and (not args.no_https):
+            print("No HTTPS port mapping (to port 443 inside the container) was specified and --no-https was not specified")
+            sys.exit(1)
+        if not http_port:
+            print("Port mapping must include a mapping to port 80 inside the container")
+            sys.exit(1)
+
+    ## Check if it's installed
+    installed = False
+    return_code = subprocess.call("docker ps -a | grep -q layersapp", shell=True)
+    if return_code == 0:
+        installed = True
+
+    if args.uninstall:
+        if not installed:
+            print("Cannot uninstall - application does not appear to be installed")
+            sys.exit(1)
+    elif args.update:
+        if not installed:
+            print("Application container not found - update mode can only be used on an existing installation")
+            sys.exit(1)
+        if dbapassword == 'testingpw':
+            print("Update mode can only be used when previous configuration is still present in docker-compose.yml and other files")
+            sys.exit(1)
+    elif installed and not args.reinstall:
+        print('Application already installed. Please use -u/--update to update or -r/--reinstall to reinstall')
         sys.exit(1)
-elif installed and not args.reinstall:
-    print('Application already installed. Please use -u/--update to update or -r/--reinstall to reinstall')
-    sys.exit(1)
 
-if not args.uninstall:
-    print("""
+    if not args.uninstall:
+        print("""
 OE Layer Index Docker setup script
 ----------------------------------
 
@@ -723,232 +728,236 @@ Note that this script does have interactive prompts, so be prepared to
 provide information as needed.
 """)
 
-if not (args.update or args.uninstall) and not email_host:
-    print("""  WARNING: no email host has been specified - functions that require email
+    if not (args.update or args.uninstall) and not email_host:
+        print("""  WARNING: no email host has been specified - functions that require email
   (such as and new account registraion, password reset and error reports will
   not work without it. If you wish to correct this, press Ctrl+C now and then
   re-run specifying the email host with the --email-host option.
 """)
 
-if args.reinstall:
-    print("""  WARNING: continuing will wipe out any existing data in the database and set
+    if args.reinstall:
+        print("""  WARNING: continuing will wipe out any existing data in the database and set
   up the application from scratch! Press Ctrl+C now if this is not what you
   want.
 """)
 
-if args.uninstall:
-    print("""
+    if args.uninstall:
+        print("""
   WARNING: continuing will wipe out any existing data in the database and
   uninstall the application. Press Ctrl+C now if this is not what you want.
 """)
 
-try:
-    if args.uninstall:
-        promptstr = 'Press Enter to begin uninstallation (or Ctrl+C to exit)...'
-    elif args.update:
-        promptstr = 'Press Enter to begin update (or Ctrl+C to exit)...'
-    else:
-        promptstr = 'Press Enter to begin setup (or Ctrl+C to exit)...'
-    input(promptstr)
-except KeyboardInterrupt:
-    print('')
-    sys.exit(2)
-
-if not (args.update or args.uninstall):
-    # Get email address
-    print('')
-    if args.letsencrypt:
-        print('You will now be asked for an email address. This will be used for the superuser account, to send error reports to and for Let\'s Encrypt.')
-    else:
-        print('You will now be asked for an email address. This will be used for the superuser account and to send error reports to.')
-    emailaddr = None
-    while True:
-        emailaddr = input('Enter your email address: ')
-        if '@' in emailaddr:
-            break
+    try:
+        if args.uninstall:
+            promptstr = 'Press Enter to begin uninstallation (or Ctrl+C to exit)...'
+        elif args.update:
+            promptstr = 'Press Enter to begin update (or Ctrl+C to exit)...'
         else:
-            print('Entered email address is not valid')
-
-if args.reinstall or args.uninstall:
-    return_code = subprocess.call(['docker-compose', 'down', '-v'], shell=False)
-
-if args.uninstall:
-    # We're done
-    print('Uninstallation completed')
-    sys.exit(0)
+            promptstr = 'Press Enter to begin setup (or Ctrl+C to exit)...'
+        input(promptstr)
+    except KeyboardInterrupt:
+        print('')
+        sys.exit(2)
 
-if args.update:
-    args.no_https = read_dockerfile_web()
-    if not args.no_https:
-        container_cert_dir = args.app_dir + '/cert'
-        args.hostname, https_port, certdir, certfile, keyfile = read_nginx_ssl_conf(container_cert_dir)
-        edit_nginx_ssl_conf(args.hostname, https_port, certdir, certfile, keyfile)
-else:
-    # Always edit these in case we switch from proxy to no proxy
-    edit_gitproxy(socks_proxy_host, socks_proxy_port, args.no_proxy)
-    edit_dockerfile(args.http_proxy, args.https_proxy, args.no_proxy)
-    write_env_file(args.app_dir)
+    if not (args.update or args.uninstall):
+        # Get email address
+        print('')
+        if args.letsencrypt:
+            print('You will now be asked for an email address. This will be used for the superuser account, to send error reports to and for Let\'s Encrypt.')
+        else:
+            print('You will now be asked for an email address. This will be used for the superuser account and to send error reports to.')
+        emailaddr = None
+        while True:
+            emailaddr = input('Enter your email address: ')
+            if '@' in emailaddr:
+                break
+            else:
+                print('Entered email address is not valid')
 
-    write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, email_host, email_port, args.email_user, args.email_password, args.email_ssl, args.email_tls)
-    edit_dockercompose(args.hostname, args.portmapping, args.letsencrypt, args.app_dir)
+    if args.reinstall or args.uninstall:
+        return_code = subprocess.call(['docker-compose', 'down', '-v'], shell=False)
 
-    edit_dockerfile_web(args.hostname, args.no_https)
+    if args.uninstall:
+        # We're done
+        print('Uninstallation completed')
+        sys.exit(0)
 
-    edit_settings_py(emailaddr, args.app_dir)
+    if args.update:
+        args.no_https = read_dockerfile_web()
+        if not args.no_https:
+            container_cert_dir = args.app_dir + '/cert'
+            args.hostname, https_port, certdir, certfile, keyfile = read_nginx_ssl_conf(container_cert_dir)
+            edit_nginx_ssl_conf(args.hostname, https_port, certdir, certfile, keyfile)
+    else:
+        # Always edit these in case we switch from proxy to no proxy
+        edit_gitproxy(socks_proxy_host, socks_proxy_port, args.no_proxy)
+        edit_dockerfile(args.http_proxy, args.https_proxy, args.no_proxy)
+        write_env_file(args.app_dir)
 
-    edit_options_file(args.project_name)
+        write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, email_host, email_port, args.email_user, args.email_password, args.email_ssl, args.email_tls)
+        edit_dockercompose(args.hostname, args.portmapping, args.letsencrypt, args.app_dir)
 
-    if not args.no_https:
-        setup_https(args.hostname, http_port, https_port, args.letsencrypt, args.letsencrypt_production, args.cert, args.cert_key, emailaddr, args.app_dir)
+        edit_dockerfile_web(args.hostname, args.no_https)
 
-## Start up containers
-return_code = subprocess.call(['docker-compose', 'up', '-d', '--build'], shell=False)
-if return_code != 0:
-    print("docker-compose up failed")
-    sys.exit(1)
+        edit_settings_py(emailaddr, args.app_dir)
 
-if not (args.update or args.no_connectivity):
-    ## Run connectivity check
-    check_connectivity(args.app_dir)
-
-# Get real project name (if only there were a reasonable way to do this... ugh)
-real_project_name = ''
-output = subprocess.check_output(['docker-compose', 'ps', '-q'], shell=False)
-if output:
-    output = output.decode('utf-8')
-    for contid in output.splitlines():
-        output = subprocess.check_output(['docker', 'inspect', '-f', '{{ .Mounts }}', contid], shell=False)
-        if output:
-            output = output.decode('utf-8')
-            for volume in re.findall('volume ([^ ]+)', output):
-                if '_' in volume:
-                    real_project_name = volume.rsplit('_', 1)[0]
-                    break
-            if real_project_name:
-                break
-if not real_project_name:
-    print('Failed to detect docker-compose project name')
-    sys.exit(1)
+        edit_options_file(args.project_name)
 
-# Database might not be ready yet; have to wait then poll.
-time.sleep(8)
-while True:
-    time.sleep(2)
-    # Pass credentials through environment for slightly better security
-    # (avoids password being visible through ps or /proc/<pid>/cmdline)
-    env = os.environ.copy()
-    env['MYSQL_PWD'] = dbapassword
-    # Dummy command, we just want to establish that the db can be connected to
-    return_code = subprocess.call("echo | docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb", shell=True, env=env)
-    if return_code == 0:
-        break
-    else:
-        print("Database server may not be ready; will try again.")
-
-if not args.update:
-    # Import the user's supplied data
-    if args.databasefile:
-        filename, file_extension = os.path.splitext(args.databasefile)
-        if file_extension == ".zst":
-            return_code = subprocess.call("zstd -t %s > /dev/null 2>&1" % quote(args.databasefile), shell=True)
-            if return_code == 0:
-                catcmd = 'zstdcat'
-        elif file_extension == ".gz":
-            return_code = subprocess.call("gunzip -t %s > /dev/null 2>&1" % quote(args.databasefile), shell=True)
-            if return_code == 0:
-                catcmd = 'zcat'
-        else:
-            catcmd = 'cat'
-        env = os.environ.copy()
-        env['MYSQL_PWD'] = dbapassword
-        return_code = subprocess.call("%s %s | docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb" % (catcmd, quote(args.databasefile)), shell=True, env=env)
-        if return_code != 0:
-            print("Database import failed")
-            sys.exit(1)
+        if not args.no_https:
+            setup_https(args.hostname, http_port, https_port, args.letsencrypt, args.letsencrypt_production, args.cert, args.cert_key, emailaddr, args.app_dir)
 
-if not args.no_migrate:
-    # Apply any pending layerindex migrations / initialize the database.
-    env = os.environ.copy()
-    env['DATABASE_USER'] = 'root'
-    env['DATABASE_PASSWORD'] = dbapassword
-    return_code = subprocess.call(['docker-compose', 'run', '--rm', '-e', 'DATABASE_USER', '-e', 'DATABASE_PASSWORD', 'layersapp', args.app_dir + '/migrate.sh'], shell=False, env=env)
+    ## Start up containers
+    return_code = subprocess.call(['docker-compose', 'up', '-d', '--build'], shell=False)
     if return_code != 0:
-        print("Applying migrations failed")
+        print("docker-compose up failed")
         sys.exit(1)
 
-if not args.update:
-    # Create normal database user for app to use
-    with tempfile.NamedTemporaryFile('w', dir=os.getcwd(), delete=False) as tf:
-        sqlscriptfile = tf.name
-        tf.write("DROP USER IF EXISTS layers;")
-        tf.write("CREATE USER layers IDENTIFIED BY '%s';\n" % dbpassword)
-        tf.write("GRANT SELECT, UPDATE, INSERT, DELETE ON layersdb.* TO layers;\n")
-        tf.write("FLUSH PRIVILEGES;\n")
-    try:
+    if not (args.update or args.no_connectivity):
+        ## Run connectivity check
+        check_connectivity(args.app_dir)
+
+    # Get real project name (if only there were a reasonable way to do this... ugh)
+    real_project_name = ''
+    output = subprocess.check_output(['docker-compose', 'ps', '-q'], shell=False)
+    if output:
+        output = output.decode('utf-8')
+        for contid in output.splitlines():
+            output = subprocess.check_output(['docker', 'inspect', '-f', '{{ .Mounts }}', contid], shell=False)
+            if output:
+                output = output.decode('utf-8')
+                for volume in re.findall('volume ([^ ]+)', output):
+                    if '_' in volume:
+                        real_project_name = volume.rsplit('_', 1)[0]
+                        break
+                if real_project_name:
+                    break
+    if not real_project_name:
+        print('Failed to detect docker-compose project name')
+        sys.exit(1)
+
+    # Database might not be ready yet; have to wait then poll.
+    time.sleep(8)
+    while True:
+        time.sleep(2)
         # Pass credentials through environment for slightly better security
         # (avoids password being visible through ps or /proc/<pid>/cmdline)
         env = os.environ.copy()
         env['MYSQL_PWD'] = dbapassword
-        return_code = subprocess.call("docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb < " + quote(sqlscriptfile), shell=True, env=env)
-        if return_code != 0:
-            print("Creating database user failed")
-            sys.exit(1)
-    finally:
-        os.remove(sqlscriptfile)
+        # Dummy command, we just want to establish that the db can be connected to
+        return_code = subprocess.call("echo | docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb", shell=True, env=env)
+        if return_code == 0:
+            break
+        else:
+            print("Database server may not be ready; will try again.")
+
+    if not args.update:
+        # Import the user's supplied data
+        if args.databasefile:
+            filename, file_extension = os.path.splitext(args.databasefile)
+            if file_extension == ".zst":
+                return_code = subprocess.call("zstd -t %s > /dev/null 2>&1" % quote(args.databasefile), shell=True)
+                if return_code == 0:
+                    catcmd = 'zstdcat'
+            elif file_extension == ".gz":
+                return_code = subprocess.call("gunzip -t %s > /dev/null 2>&1" % quote(args.databasefile), shell=True)
+                if return_code == 0:
+                    catcmd = 'zcat'
+            else:
+                catcmd = 'cat'
+            env = os.environ.copy()
+            env['MYSQL_PWD'] = dbapassword
+            return_code = subprocess.call("%s %s | docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb" % (catcmd, quote(args.databasefile)), shell=True, env=env)
+            if return_code != 0:
+                print("Database import failed")
+                sys.exit(1)
 
-    ## Set the volume permissions using debian:stretch since we recently fetched it
-    volumes = ['layersmeta', 'layersstatic', 'logvolume']
-    with open('docker-compose.yml', 'r') as f:
-        for line in f:
-            if line.lstrip().startswith('- srcvolume:'):
-                volumes.append('srcvolume')
-                break
-    for volume in volumes:
-        volname = '%s_%s' % (real_project_name, volume)
-        return_code = subprocess.call(['docker', 'run', '--rm', '-v', '%s:%s/mount' % (volname, args.app_dir), 'debian:stretch', 'chown', '500', args.app_dir + '/mount'], shell=False)
+    if not args.no_migrate:
+        # Apply any pending layerindex migrations / initialize the database.
+        env = os.environ.copy()
+        env['DATABASE_USER'] = 'root'
+        env['DATABASE_PASSWORD'] = dbapassword
+        return_code = subprocess.call(['docker-compose', 'run', '--rm', '-e', 'DATABASE_USER', '-e', 'DATABASE_PASSWORD', 'layersapp', args.app_dir + '/migrate.sh'], shell=False, env=env)
         if return_code != 0:
-            print("Setting volume permissions for volume %s failed" % volume)
+            print("Applying migrations failed")
             sys.exit(1)
 
-## Generate static assets. Run this command again to regenerate at any time (when static assets in the code are updated)
-return_code = subprocess.call("docker-compose run --rm -e STATIC_ROOT=/usr/share/nginx/html -v %s_layersstatic:/usr/share/nginx/html layersapp %s/layerindex/manage.py collectstatic --noinput" % (quote(real_project_name), args.app_dir), shell = True)
-if return_code != 0:
-    print("Collecting static files failed")
-    sys.exit(1)
+    if not args.update:
+        # Create normal database user for app to use
+        with tempfile.NamedTemporaryFile('w', dir=os.getcwd(), delete=False) as tf:
+            sqlscriptfile = tf.name
+            tf.write("DROP USER IF EXISTS layers;")
+            tf.write("CREATE USER layers IDENTIFIED BY '%s';\n" % dbpassword)
+            tf.write("GRANT SELECT, UPDATE, INSERT, DELETE ON layersdb.* TO layers;\n")
+            tf.write("FLUSH PRIVILEGES;\n")
+        try:
+            # Pass credentials through environment for slightly better security
+            # (avoids password being visible through ps or /proc/<pid>/cmdline)
+            env = os.environ.copy()
+            env['MYSQL_PWD'] = dbapassword
+            return_code = subprocess.call("docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb < " + quote(sqlscriptfile), shell=True, env=env)
+            if return_code != 0:
+                print("Creating database user failed")
+                sys.exit(1)
+        finally:
+            os.remove(sqlscriptfile)
 
-if https_port and not args.no_https:
-    protocol = 'https'
-    port = https_port
-    defport = '443'
-else:
-    protocol = 'http'
-    port = http_port
-    defport = '80'
-if port == defport:
-    host = args.hostname
-else:
-    host = '%s:%s' % (args.hostname, port)
-
-if not args.update:
-    if not args.databasefile:
-        ## Set site name
-        return_code = subprocess.call(['docker-compose', 'run', '--rm', 'layersapp', args.app_dir + '/layerindex/layerindex/tools/site_name.py', host, 'OpenEmbedded Layer Index'], shell=False)
-
-    if not args.no_admin_user:
-        ## For a fresh database, create an admin account
-        print("Creating database superuser. Input user name and password when prompted.")
-        return_code = subprocess.call(['docker-compose', 'run', '--rm', 'layersapp', args.app_dir + '/layerindex/manage.py', 'createsuperuser', '--email', emailaddr], shell=False)
-        if return_code != 0:
-            print("Creating superuser failed")
-            sys.exit(1)
+        ## Set the volume permissions using debian:stretch since we recently fetched it
+        volumes = ['layersmeta', 'layersstatic', 'logvolume']
+        with open('docker-compose.yml', 'r') as f:
+            for line in f:
+                if line.lstrip().startswith('- srcvolume:'):
+                    volumes.append('srcvolume')
+                    break
+        for volume in volumes:
+            volname = '%s_%s' % (real_project_name, volume)
+            return_code = subprocess.call(['docker', 'run', '--rm', '-v', '%s:%s/mount' % (volname, args.app_dir), 'debian:stretch', 'chown', '500', args.app_dir + '/mount'], shell=False)
+            if return_code != 0:
+                print("Setting volume permissions for volume %s failed" % volume)
+                sys.exit(1)
 
+    ## Generate static assets. Run this command again to regenerate at any time (when static assets in the code are updated)
+    return_code = subprocess.call("docker-compose run --rm -e STATIC_ROOT=/usr/share/nginx/html -v %s_layersstatic:/usr/share/nginx/html layersapp %s/layerindex/manage.py collectstatic --noinput" % (quote(real_project_name), args.app_dir), shell = True)
+    if return_code != 0:
+        print("Collecting static files failed")
+        sys.exit(1)
 
-if args.update:
-    print("Update complete")
-else:
-    if args.project_name:
+    if https_port and not args.no_https:
+        protocol = 'https'
+        port = https_port
+        defport = '443'
+    else:
+        protocol = 'http'
+        port = http_port
+        defport = '80'
+    if port == defport:
+        host = args.hostname
+    else:
+        host = '%s:%s' % (args.hostname, port)
+
+    if not args.update:
+        if not args.databasefile:
+            ## Set site name
+            return_code = subprocess.call(['docker-compose', 'run', '--rm', 'layersapp', args.app_dir + '/layerindex/layerindex/tools/site_name.py', host, 'OpenEmbedded Layer Index'], shell=False)
+
+        if not args.no_admin_user:
+            ## For a fresh database, create an admin account
+            print("Creating database superuser. Input user name and password when prompted.")
+            return_code = subprocess.call(['docker-compose', 'run', '--rm', 'layersapp', args.app_dir + '/layerindex/manage.py', 'createsuperuser', '--email', emailaddr], shell=False)
+            if return_code != 0:
+                print("Creating superuser failed")
+                sys.exit(1)
+
+
+    if args.update:
+        print("Update complete")
+    else:
+        if args.project_name:
+            print("")
+            print("NOTE: you may need to use -p %s (or set COMPOSE_PROJECT_NAME=\"%s\" ) if running docker-compose directly in future" % (args.project_name, args.project_name))
         print("")
-        print("NOTE: you may need to use -p %s (or set COMPOSE_PROJECT_NAME=\"%s\" ) if running docker-compose directly in future" % (args.project_name, args.project_name))
-    print("")
-    print("The application should now be accessible at %s://%s" % (protocol, host))
-    print("")
+        print("The application should now be accessible at %s://%s" % (protocol, host))
+        print("")
+
+
+if __name__ == '__main__':
+    main()
-- 
2.56.0


