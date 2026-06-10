Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D45CD98CE
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 18:51:54 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28447.1781117506041549171
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 11:51:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=OrK8T8LQ;
 spf=pass (domain: konsulko.com, ip: 74.125.224.42, mailfrom: tim.orling@konsulko.com)
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-660ea43107fso6875215d50.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781117505; cv=none;
        d=google.com; s=arc-20240605;
        b=DitrKrKBrf9BcrN9UUW/r7fOY3jlRQZuJHy084pdsO4XeSwaEuZ0s2CZ9CcRyVdFtV
         WRYYUB201ZGussm593smYqZsYKsY5VwaDVynuFrWvNEIh7IA0WKRsxK5PIWZ0pdrnNmW
         opVL6DD1lN+Urhp+tPZMHLsO/LIpkIEVjWAlO1KCiSoGBrIuwdFBozqpiYtjolH4Qoaf
         8N9PaA0e7ivuTJFYQ+afavqnuuXqQ2wM2Ldx6P9KImCtL1lTAlwxFbc+SnyQWIlLkuDS
         R43KIBqYMiOgYNHCBqWKm24Iiiu8ztHg/mhzxhJ1Jw4LNyf9X0QdhOT+ikVewxc8qwxR
         4JTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lmv6MOpW6zl4UzFnOoqJif+XEmXgNIhnbZFdrI9vJ2U=;
        fh=oelZnrg5dmur//Cq9EZ6v+RhAeHGCj2nFzzrUJxuFwI=;
        b=gAXjDVJ69XAuQrtSFpAiFbOPhbPAduDmXBpFoZhs1LsRGXUKvayrmhKtQRTr5kiB0M
         4YPM4jXI2GAZhssO7BcaKXXLjd4ZnfS5H4/MTwx8LiXk7aEJYnvpgpufyAleaJxXrZKW
         KmMm/L3U/TOFMdmMCv41dduvxU1Tqx9TiUelMEyZaaGTnsTfx2R3N698Z9rvUxAEkt89
         BIKEVsQkGf+gvPFe0/Db6S3XqvvkuB5f0Dn6l95wx70xZqZ5ykXBCDicuo+cKPWxg7N+
         GYom3nrqGQSs2MSe9rKN8IWWOzX7lObV1L4f0NJ/9/hfJ3PqOYhjDe+ucff0o30KEvEf
         SJAQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1781117505; x=1781722305; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmv6MOpW6zl4UzFnOoqJif+XEmXgNIhnbZFdrI9vJ2U=;
        b=OrK8T8LQjH3Ss3uaUDr/BObK1jEaeq86B73j0L0ILjJMUscDntQueYKglh1vKtdzfG
         cK68vEXOSYx3pPR7SSh7uHJD3G/fAhbb9BjhvsO7jn+OC+oF3IcGE7byCi2wnX8Fr1vi
         IdJmxcoEYbDQmgo4HTuIWU2nYSgPBWUahiI1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781117505; x=1781722305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmv6MOpW6zl4UzFnOoqJif+XEmXgNIhnbZFdrI9vJ2U=;
        b=MfI8fKRmFNp6WEZpLBRKrGzhbyHfIbcqnnzZEbGbhEMX7m2JXtlynklmuF0IZlKbGE
         ZGPijqPcchj4rkT9fKRmUzceMLhhja1p6F3vO5q/fFSVZK7zLTHhzG+r6h7UfEcS9U4a
         YZ6bppKuBcvjwxVwVJelBt4In0Ve6uE66+ljz0Fe/7EPUEgL8BYoKuV/K7RuJzkZcnkl
         6I0Y8XrDeHWi5MSCRZ7L05liTF3z7UcOPfQaDj60sBRJ1G4noqgBd4WNvfcNhhOZ3fsy
         YjC0HxAyTwNvfjzFTe2j1BAD3ckw38Zg2mTbJkSYB1aHpQ0ivi/JxGea2ftLOFX7G7lX
         DMAg==
X-Gm-Message-State: AOJu0YzQ9zN/N/30oMYS6t4MdjzfcEcOub8Dl0XxPIIbDNUNYx2EvosR
	WmaSukXyPa6QaAmLS/llsnPongXPa//kNtGG2YMrMln62uwWoD7npQyPiQZPHBVvOHlTn4rm589
	t7O8YD17dMmho14KYDUt7syMPEvx/LWp8ZFRGmY+umQ==
X-Gm-Gg: Acq92OFCJzQwPCIyAo8Fij3uCCkxT4EeGgMVR8zzjrxT9l7j/1B0cI1pp955amPZ5r5
	JVKh4cPzA5w6rttAo3O1IyWooHW2Bq2FJgu9K5zb83zI4Ob38uinVA2qKh8a/XP+/9sNCvHAXIl
	Osu7g4uOTvng3LrFhiQn9mQiLgYQCMXRTyVLO2n7Kw1xgoGwZF0RbpAl50U9jhifIXvv2xh7cgE
	rIxIIEDgPyisuDwosZMMQd8CnikOxfngOipcRU0CqRaTU+cPLgN4A6aJQ2eyp6xoiqJTWNfti5S
	XkRYrILrfaQ1+RfhNw==
X-Received: by 2002:a05:690c:e34d:b0:7a1:3088:e528 with SMTP id
 00721157ae682-7ed0adbfd8bmr270130967b3.18.1781117504825; Wed, 10 Jun 2026
 11:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com> <20260609164032.1415124-2-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20260609164032.1415124-2-sandeep.gundlupet-raju@amd.com>
From: Tim Orling <tim.orling@konsulko.com>
Date: Wed, 10 Jun 2026 11:51:32 -0700
X-Gm-Features: AVVi8CfGBhxGvTKnOUUxPK0wjm57QNwBzps2BkfhPzPUah8xsQsjJgWKF7CfCwY
Message-ID: <CAOyo-84JJuvhVMc0L02vCFkHUq0E+C=-B28vi_3SBGKCAv8ydw@mail.gmail.com>
Subject: Re: [yocto-patches] [layerindex-web][PATCH v3 1/4] layerindex: Add
 app dir support for configurable container
To: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Cc: yocto-patches@lists.yoctoproject.org, mark.hatle@kernel.crashing.org, 
	piotr@qbee.io
Content-Type: multipart/alternative; boundary="0000000000002db94b0653eabcb2"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 18:51:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4203

--0000000000002db94b0653eabcb2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged.

On Tue, Jun 9, 2026 at 9:40=E2=80=AFAM Sandeep Gundlupet Raju <
sandeep.gundlupet-raju@amd.com> wrote:

> Add a new --app-dir command-line argument (default: /opt) to allow the
> base directory used inside the containers to be configurable instead of
> being hardcoded to /opt.
>
> Changes:
> - dockersetup.py: add --app-dir argument; write APP_DIR to .env file via
>   new write_env_file() so docker-compose passes it as a build arg; update
>   edit_dockercompose() to expand build: block and inject APP_DIR build ar=
g
>   reference, and rewrite volume mounts and celery --workdir accordingly;
>   propagate app_dir through setup_https(), check_connectivity(), and all
>   direct docker-compose run call sites
> - Dockerfile: add ARG APP_DIR=3D/opt + ENV APP_DIR=3D${APP_DIR}; replace =
all
>   hardcoded /opt paths with ${APP_DIR} in COPY, RUN and CMD instructions
> - docker/migrate.sh: replace /opt with ${APP_DIR:-/opt}
> - docker/refreshlayers.sh: replace /opt with ${APP_DIR:-/opt}
> - docker/updatelayers.sh: replace /opt with ${APP_DIR:-/opt}
> - Pass app_dir to edit_settings_py() and replace the hardcoded
>   LAYER_FETCH_DIR =3D "/opt/workdir" with app_dir + "/workdir", so
>   the fetch directory respects the --app-dir option.
>
> AI-Generated: GitHub Copilot (Claude Sonnet 4.6)
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>  Dockerfile              | 24 ++++++------
>  docker/migrate.sh       |  2 +-
>  docker/refreshlayers.sh |  2 +-
>  docker/updatelayers.sh  |  2 +-
>  dockersetup.py          | 86 +++++++++++++++++++++++++++++++++--------
>  5 files changed, 85 insertions(+), 31 deletions(-)
>
> diff --git a/Dockerfile b/Dockerfile
> index 72f57d2..8e6e508 100644
> --- a/Dockerfile
> +++ b/Dockerfile
> @@ -3,6 +3,8 @@
>  FROM ubuntu:jammy
>  LABEL maintainer=3D"Michael Halstead <mhalstead@linuxfoundation.org>"
>
> +ARG APP_DIR=3D/opt
> +ENV APP_DIR=3D${APP_DIR}
>  ENV PYTHONUNBUFFERED=3D1 \
>      LANGUAGE=3Den_US \
>      LANG=3Den_US.UTF-8 \
> @@ -55,22 +57,22 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive apt-get update \
>         && rm -rf /var/lib/apt/lists/* \
>         && apt-get clean
>
> -COPY . /opt/layerindex
> -RUN rm -rf /opt/layerindex/docker
> -COPY docker/settings.py /opt/layerindex/settings.py
> -COPY docker/refreshlayers.sh /opt/refreshlayers.sh
> -COPY docker/updatelayers.sh /opt/updatelayers.sh
> -COPY docker/migrate.sh /opt/migrate.sh
> -COPY docker/connectivity_check.sh /opt/connectivity_check.sh
> +COPY . ${APP_DIR}/layerindex
> +RUN rm -rf ${APP_DIR}/layerindex/docker
> +COPY docker/settings.py ${APP_DIR}/layerindex/settings.py
> +COPY docker/refreshlayers.sh ${APP_DIR}/refreshlayers.sh
> +COPY docker/updatelayers.sh ${APP_DIR}/updatelayers.sh
> +COPY docker/migrate.sh ${APP_DIR}/migrate.sh
> +COPY docker/connectivity_check.sh ${APP_DIR}/connectivity_check.sh
>
> -RUN mkdir /opt/workdir \
> +RUN mkdir ${APP_DIR}/workdir \
>         && adduser --system --uid=3D500 layers \
> -       && chown -R layers /opt/workdir
> +       && chown -R layers ${APP_DIR}/workdir
>  USER layers
>
>  # Always copy in .gitconfig and proxy helper script (they need editing t=
o
> be active)
>  COPY docker/.gitconfig /home/layers/.gitconfig
> -COPY docker/git-proxy /opt/bin/git-proxy
> +COPY docker/git-proxy ${APP_DIR}/bin/git-proxy
>
>  # Start Gunicorn
> -CMD ["/usr/local/bin/gunicorn", "wsgi:application", "--workers=3D4",
> "--bind=3D:5000", "--timeout=3D60", "--log-level=3Ddebug",
> "--chdir=3D/opt/layerindex"]
> +CMD ["/bin/sh", "-c", "/usr/local/bin/gunicorn wsgi:application
> --workers=3D4 --bind=3D:5000 --timeout=3D60 --log-level=3Ddebug
> --chdir=3D${APP_DIR}/layerindex"]
> diff --git a/docker/migrate.sh b/docker/migrate.sh
> index ca15368..bb9f646 100755
> --- a/docker/migrate.sh
> +++ b/docker/migrate.sh
> @@ -1,2 +1,2 @@
>  #!/bin/bash
> -python3 /opt/layerindex/manage.py migrate "$@"
> +python3 ${APP_DIR:-/opt}/layerindex/manage.py migrate "$@"
> diff --git a/docker/refreshlayers.sh b/docker/refreshlayers.sh
> index 0c550bd..5adaf86 100755
> --- a/docker/refreshlayers.sh
> +++ b/docker/refreshlayers.sh
> @@ -1,3 +1,3 @@
>  #!/bin/bash
> -update=3D/opt/layerindex/layerindex/update.py
> +update=3D${APP_DIR:-/opt}/layerindex/layerindex/update.py
>  $update -q -r
> diff --git a/docker/updatelayers.sh b/docker/updatelayers.sh
> index 21640ba..6f0e8f0 100755
> --- a/docker/updatelayers.sh
> +++ b/docker/updatelayers.sh
> @@ -1,3 +1,3 @@
>  #!/bin/bash
> -update=3D/opt/layerindex/layerindex/update.py
> +update=3D${APP_DIR:-/opt}/layerindex/layerindex/update.py
>  $update -q
> diff --git a/dockersetup.py b/dockersetup.py
> index bc7478c..3a74eb3 100755
> --- a/dockersetup.py
> +++ b/dockersetup.py
> @@ -70,6 +70,7 @@ def get_args():
>      parser.add_argument('--no-migrate', action=3D"store_true",
> default=3DFalse, help=3D'Skip running database migrations')
>      parser.add_argument('--no-admin-user', action=3D"store_true",
> default=3DFalse, help=3D'Skip adding admin user')
>      parser.add_argument('--no-connectivity', action=3D"store_true",
> default=3DFalse, help=3D'Skip checking external network connectivity')
> +    parser.add_argument('--app-dir', type=3Dstr, help=3D'Base directory
> inside the container for application files. Default is %(default)s',
> required=3DFalse, default=3D'/opt')
>
>      args =3D parser.parse_args()
>
> @@ -253,14 +254,16 @@ def yaml_comment(line):
>
>
>  # Add hostname, secret key, db info, and email host in docker-compose.ym=
l
> -def edit_dockercompose(hostname, dbpassword, dbapassword, secretkey,
> rmqpassword, portmapping, letsencrypt, email_host, email_port, email_user=
,
> email_password, email_ssl, email_tls):
> +def edit_dockercompose(hostname, dbpassword, dbapassword, secretkey,
> rmqpassword, portmapping, letsencrypt, email_host, email_port, email_user=
,
> email_password, email_ssl, email_tls, app_dir=3D'/opt'):
> +
> +    in_layersapp_build =3D False
>
>      def adjust_cert_mount_line(ln):
>          linesplit =3D ln.split(':')
>          if letsencrypt:
>              linesplit[1] =3D '/etc/letsencrypt'
>          else:
> -            linesplit[1] =3D '/opt/cert'
> +            linesplit[1] =3D app_dir + '/cert'
>          # This allows us to handle if there is a ":ro" or similar on the
> end
>          return ':'.join(linesplit)
>
> @@ -305,6 +308,33 @@ def edit_dockercompose(hostname, dbpassword,
> dbapassword, secretkey, rmqpassword
>                  newlines.append(ucline + '\n')
>              else:
>                  newlines.append(yaml_comment(line) + '\n')
> +        elif re.match(r'^\s+build:\s+\.$', line):
> +            # Convert inline 'build: .' to block form so we can pass
> APP_DIR as a build arg
> +            indent =3D line[:len(line) - len(line.lstrip())]
> +            newlines.append(indent + 'build:\n')
> +            newlines.append(indent + '  context: .\n')
> +            newlines.append(indent + '  args:\n')
> +            newlines.append(indent + '    - APP_DIR=3D${APP_DIR}\n')
> +            in_layersapp_build =3D True
> +            continue
> +        elif '- APP_DIR=3D' in line:
> +            # Keep APP_DIR referencing the .env file (do not embed value
> here)
> +            format =3D line[:line.find('- APP_DIR=3D')].replace('#', '')
> +            newlines.append(format + '- APP_DIR=3D${APP_DIR}\n')
> +            continue
> +        elif re.match(r'^\s+context:\s+\.$', line) and in_layersapp_buil=
d:
> +            in_layersapp_build =3D False
> +            newlines.append(line + '\n')
> +            continue
> +        elif ':/opt/workdir' in line:
> +            newlines.append(line.replace(':/opt/workdir', ':' + app_dir =
+
> '/workdir') + '\n')
> +            continue
> +        elif ':/opt/layerindex-task-logs' in line:
> +            newlines.append(line.replace(':/opt/layerindex-task-logs',
> ':' + app_dir + '/layerindex-task-logs') + '\n')
> +            continue
> +        elif '--workdir=3D/opt/layerindex' in line:
> +            newlines.append(line.replace('--workdir=3D/opt/layerindex',
> '--workdir=3D' + app_dir + '/layerindex') + '\n')
> +            continue
>          elif "layersweb:" in line:
>              in_layersweb =3D True
>              newlines.append(line + "\n")
> @@ -426,7 +456,7 @@ def edit_nginx_ssl_conf(hostname, https_port, certdir=
,
> certfile, keyfile):
>      writefile("docker/nginx-ssl-edited.conf", ''.join(newlines))
>
>
> -def edit_settings_py(emailaddr):
> +def edit_settings_py(emailaddr, app_dir=3D'/opt'):
>      filedata =3D readfile('docker/settings.py')
>      newlines =3D []
>      lines =3D filedata.splitlines()
> @@ -444,6 +474,9 @@ def edit_settings_py(emailaddr):
>                  newlines.append("  ('Admin', '%s'),\n" % emailaddr)
>              newlines.append(")\n")
>              continue
> +        elif line.lstrip().startswith('LAYER_FETCH_DIR'):
> +            newlines.append("LAYER_FETCH_DIR =3D \"%s/workdir\"\n" %
> app_dir)
> +            continue
>          newlines.append(line + "\n")
>      writefile("docker/settings.py", ''.join(newlines))
>
> @@ -474,9 +507,9 @@ def edit_dockerfile_web(hostname, no_https):
>      writefile("Dockerfile.web", ''.join(newlines))
>
>
> -def setup_https(hostname, http_port, https_port, letsencrypt,
> letsencrypt_production, cert, cert_key, emailaddr):
> +def setup_https(hostname, http_port, https_port, letsencrypt,
> letsencrypt_production, cert, cert_key, emailaddr, app_dir=3D'/opt'):
>      local_cert_dir =3D os.path.abspath('docker/certs')
> -    container_cert_dir =3D '/opt/cert'
> +    container_cert_dir =3D app_dir + '/cert'
>      if letsencrypt:
>          # Create dummy cert
>          container_cert_dir =3D '/etc/letsencrypt'
> @@ -578,8 +611,26 @@ def edit_options_file(project_name):
>          f.write('project_name=3D%s\n' % project_name)
>
>
> -def check_connectivity():
> -    return_code =3D subprocess.call(['docker-compose', 'run', '--rm',
> 'layersapp', '/opt/connectivity_check.sh'], shell=3DFalse)
> +def write_env_file(app_dir):
> +    """Write APP_DIR to .env so docker-compose passes it as a build
> arg."""
> +    env_vars =3D {}
> +    try:
> +        with open('.env', 'r') as f:
> +            for line in f:
> +                line =3D line.strip()
> +                if '=3D' in line and not line.startswith('#'):
> +                    k, v =3D line.split('=3D', 1)
> +                    env_vars[k.strip()] =3D v.strip()
> +    except FileNotFoundError:
> +        pass
> +    env_vars['APP_DIR'] =3D app_dir
> +    with open('.env', 'w') as f:
> +        for k, v in env_vars.items():
> +            f.write('%s=3D%s\n' % (k, v))
> +
> +
> +def check_connectivity(app_dir=3D'/opt'):
> +    return_code =3D subprocess.call(['docker-compose', 'run', '--rm',
> 'layersapp', app_dir + '/connectivity_check.sh'], shell=3DFalse)
>      if return_code !=3D 0:
>          print("Connectivity check failed - if you are behind a proxy,
> please check that you have correctly specified the proxy settings on the
> command line (see --help for details)")
>          sys.exit(1)
> @@ -741,24 +792,25 @@ if args.uninstall:
>  if args.update:
>      args.no_https =3D read_dockerfile_web()
>      if not args.no_https:
> -        container_cert_dir =3D '/opt/cert'
> +        container_cert_dir =3D args.app_dir + '/cert'
>          args.hostname, https_port, certdir, certfile, keyfile =3D
> read_nginx_ssl_conf(container_cert_dir)
>          edit_nginx_ssl_conf(args.hostname, https_port, certdir, certfile=
,
> keyfile)
>  else:
>      # Always edit these in case we switch from proxy to no proxy
>      edit_gitproxy(socks_proxy_host, socks_proxy_port, args.no_proxy)
>      edit_dockerfile(args.http_proxy, args.https_proxy, args.no_proxy)
> +    write_env_file(args.app_dir)
>
> -    edit_dockercompose(args.hostname, dbpassword, dbapassword, secretkey=
,
> rmqpassword, args.portmapping, args.letsencrypt, email_host, email_port,
> args.email_user, args.email_password, args.email_ssl, args.email_tls)
> +    edit_dockercompose(args.hostname, dbpassword, dbapassword, secretkey=
,
> rmqpassword, args.portmapping, args.letsencrypt, email_host, email_port,
> args.email_user, args.email_password, args.email_ssl, args.email_tls,
> args.app_dir)
>
>      edit_dockerfile_web(args.hostname, args.no_https)
>
> -    edit_settings_py(emailaddr)
> +    edit_settings_py(emailaddr, args.app_dir)
>
>      edit_options_file(args.project_name)
>
>      if not args.no_https:
> -        setup_https(args.hostname, http_port, https_port,
> args.letsencrypt, args.letsencrypt_production, args.cert, args.cert_key,
> emailaddr)
> +        setup_https(args.hostname, http_port, https_port,
> args.letsencrypt, args.letsencrypt_production, args.cert, args.cert_key,
> emailaddr, args.app_dir)
>
>  ## Start up containers
>  return_code =3D subprocess.call(['docker-compose', 'up', '-d', '--build'=
],
> shell=3DFalse)
> @@ -768,7 +820,7 @@ if return_code !=3D 0:
>
>  if not (args.update or args.no_connectivity):
>      ## Run connectivity check
> -    check_connectivity()
> +    check_connectivity(args.app_dir)
>
>  # Get real project name (if only there were a reasonable way to do
> this... ugh)
>  real_project_name =3D ''
> @@ -830,7 +882,7 @@ if not args.no_migrate:
>      env =3D os.environ.copy()
>      env['DATABASE_USER'] =3D 'root'
>      env['DATABASE_PASSWORD'] =3D dbapassword
> -    return_code =3D subprocess.call(['docker-compose', 'run', '--rm', '-=
e',
> 'DATABASE_USER', '-e', 'DATABASE_PASSWORD', 'layersapp',
> '/opt/migrate.sh'], shell=3DFalse, env=3Denv)
> +    return_code =3D subprocess.call(['docker-compose', 'run', '--rm', '-=
e',
> 'DATABASE_USER', '-e', 'DATABASE_PASSWORD', 'layersapp', args.app_dir +
> '/migrate.sh'], shell=3DFalse, env=3Denv)
>      if return_code !=3D 0:
>          print("Applying migrations failed")
>          sys.exit(1)
> @@ -864,13 +916,13 @@ if not args.update:
>                  break
>      for volume in volumes:
>          volname =3D '%s_%s' % (real_project_name, volume)
> -        return_code =3D subprocess.call(['docker', 'run', '--rm', '-v',
> '%s:/opt/mount' % volname, 'debian:stretch', 'chown', '500', '/opt/mount'=
],
> shell=3DFalse)
> +        return_code =3D subprocess.call(['docker', 'run', '--rm', '-v',
> '%s:%s/mount' % (volname, args.app_dir), 'debian:stretch', 'chown', '500'=
,
> args.app_dir + '/mount'], shell=3DFalse)
>          if return_code !=3D 0:
>              print("Setting volume permissions for volume %s failed" %
> volume)
>              sys.exit(1)
>
>  ## Generate static assets. Run this command again to regenerate at any
> time (when static assets in the code are updated)
> -return_code =3D subprocess.call("docker-compose run --rm -e
> STATIC_ROOT=3D/usr/share/nginx/html -v %s_layersstatic:/usr/share/nginx/h=
tml
> layersapp /opt/layerindex/manage.py collectstatic --noinput" %
> quote(real_project_name), shell =3D True)
> +return_code =3D subprocess.call("docker-compose run --rm -e
> STATIC_ROOT=3D/usr/share/nginx/html -v %s_layersstatic:/usr/share/nginx/h=
tml
> layersapp %s/layerindex/manage.py collectstatic --noinput" %
> (quote(real_project_name), args.app_dir), shell =3D True)
>  if return_code !=3D 0:
>      print("Collecting static files failed")
>      sys.exit(1)
> @@ -891,12 +943,12 @@ else:
>  if not args.update:
>      if not args.databasefile:
>          ## Set site name
> -        return_code =3D subprocess.call(['docker-compose', 'run', '--rm'=
,
> 'layersapp', '/opt/layerindex/layerindex/tools/site_name.py', host,
> 'OpenEmbedded Layer Index'], shell=3DFalse)
> +        return_code =3D subprocess.call(['docker-compose', 'run', '--rm'=
,
> 'layersapp', args.app_dir + '/layerindex/layerindex/tools/site_name.py',
> host, 'OpenEmbedded Layer Index'], shell=3DFalse)
>
>      if not args.no_admin_user:
>          ## For a fresh database, create an admin account
>          print("Creating database superuser. Input user name and password
> when prompted.")
> -        return_code =3D subprocess.call(['docker-compose', 'run', '--rm'=
,
> 'layersapp', '/opt/layerindex/manage.py', 'createsuperuser', '--email',
> emailaddr], shell=3DFalse)
> +        return_code =3D subprocess.call(['docker-compose', 'run', '--rm'=
,
> 'layersapp', args.app_dir + '/layerindex/manage.py', 'createsuperuser',
> '--email', emailaddr], shell=3DFalse)
>          if return_code !=3D 0:
>              print("Creating superuser failed")
>              sys.exit(1)
> --
> 2.43.0
>
>

--0000000000002db94b0653eabcb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">merged.</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 9, 2026 at 9:40=
=E2=80=AFAM Sandeep Gundlupet Raju &lt;<a href=3D"mailto:sandeep.gundlupet-=
raju@amd.com">sandeep.gundlupet-raju@amd.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Add a new --app-dir command-lin=
e argument (default: /opt) to allow the<br>
base directory used inside the containers to be configurable instead of<br>
being hardcoded to /opt.<br>
<br>
Changes:<br>
- dockersetup.py: add --app-dir argument; write APP_DIR to .env file via<br=
>
=C2=A0 new write_env_file() so docker-compose passes it as a build arg; upd=
ate<br>
=C2=A0 edit_dockercompose() to expand build: block and inject APP_DIR build=
 arg<br>
=C2=A0 reference, and rewrite volume mounts and celery --workdir accordingl=
y;<br>
=C2=A0 propagate app_dir through setup_https(), check_connectivity(), and a=
ll<br>
=C2=A0 direct docker-compose run call sites<br>
- Dockerfile: add ARG APP_DIR=3D/opt + ENV APP_DIR=3D${APP_DIR}; replace al=
l<br>
=C2=A0 hardcoded /opt paths with ${APP_DIR} in COPY, RUN and CMD instructio=
ns<br>
- docker/migrate.sh: replace /opt with ${APP_DIR:-/opt}<br>
- docker/refreshlayers.sh: replace /opt with ${APP_DIR:-/opt}<br>
- docker/updatelayers.sh: replace /opt with ${APP_DIR:-/opt}<br>
- Pass app_dir to edit_settings_py() and replace the hardcoded<br>
=C2=A0 LAYER_FETCH_DIR =3D &quot;/opt/workdir&quot; with app_dir + &quot;/w=
orkdir&quot;, so<br>
=C2=A0 the fetch directory respects the --app-dir option.<br>
<br>
AI-Generated: GitHub Copilot (Claude Sonnet 4.6)<br>
<br>
Signed-off-by: Sandeep Gundlupet Raju &lt;<a href=3D"mailto:sandeep.gundlup=
et-raju@amd.com" target=3D"_blank">sandeep.gundlupet-raju@amd.com</a>&gt;<b=
r>
---<br>
=C2=A0Dockerfile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 24 +++++=
+------<br>
=C2=A0docker/migrate.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0docker/refreshlayers.sh |=C2=A0 2 +-<br>
=C2=A0docker/updatelayers.sh=C2=A0 |=C2=A0 2 +-<br>
=C2=A0dockersetup.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 86 +++++++++++++++=
++++++++++++++++++--------<br>
=C2=A05 files changed, 85 insertions(+), 31 deletions(-)<br>
<br>
diff --git a/Dockerfile b/Dockerfile<br>
index 72f57d2..8e6e508 100644<br>
--- a/Dockerfile<br>
+++ b/Dockerfile<br>
@@ -3,6 +3,8 @@<br>
=C2=A0FROM ubuntu:jammy<br>
=C2=A0LABEL maintainer=3D&quot;Michael Halstead &lt;<a href=3D"mailto:mhals=
tead@linuxfoundation.org" target=3D"_blank">mhalstead@linuxfoundation.org</=
a>&gt;&quot;<br>
<br>
+ARG APP_DIR=3D/opt<br>
+ENV APP_DIR=3D${APP_DIR}<br>
=C2=A0ENV PYTHONUNBUFFERED=3D1 \<br>
=C2=A0 =C2=A0 =C2=A0LANGUAGE=3Den_US \<br>
=C2=A0 =C2=A0 =C2=A0LANG=3Den_US.UTF-8 \<br>
@@ -55,22 +57,22 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive apt-get update \<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; rm -rf /var/lib/apt/lists/* \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; apt-get clean<br>
<br>
-COPY . /opt/layerindex<br>
-RUN rm -rf /opt/layerindex/docker<br>
-COPY docker/settings.py /opt/layerindex/settings.py<br>
-COPY docker/refreshlayers.sh /opt/refreshlayers.sh<br>
-COPY docker/updatelayers.sh /opt/updatelayers.sh<br>
-COPY docker/migrate.sh /opt/migrate.sh<br>
-COPY docker/connectivity_check.sh /opt/connectivity_check.sh<br>
+COPY . ${APP_DIR}/layerindex<br>
+RUN rm -rf ${APP_DIR}/layerindex/docker<br>
+COPY docker/settings.py ${APP_DIR}/layerindex/settings.py<br>
+COPY docker/refreshlayers.sh ${APP_DIR}/refreshlayers.sh<br>
+COPY docker/updatelayers.sh ${APP_DIR}/updatelayers.sh<br>
+COPY docker/migrate.sh ${APP_DIR}/migrate.sh<br>
+COPY docker/connectivity_check.sh ${APP_DIR}/connectivity_check.sh<br>
<br>
-RUN mkdir /opt/workdir \<br>
+RUN mkdir ${APP_DIR}/workdir \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; adduser --system --uid=3D500 layers =
\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; chown -R layers /opt/workdir<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; chown -R layers ${APP_DIR}/workdir<b=
r>
=C2=A0USER layers<br>
<br>
=C2=A0# Always copy in .gitconfig and proxy helper script (they need editin=
g to be active)<br>
=C2=A0COPY docker/.gitconfig /home/layers/.gitconfig<br>
-COPY docker/git-proxy /opt/bin/git-proxy<br>
+COPY docker/git-proxy ${APP_DIR}/bin/git-proxy<br>
<br>
=C2=A0# Start Gunicorn<br>
-CMD [&quot;/usr/local/bin/gunicorn&quot;, &quot;wsgi:application&quot;, &q=
uot;--workers=3D4&quot;, &quot;--bind=3D:5000&quot;, &quot;--timeout=3D60&q=
uot;, &quot;--log-level=3Ddebug&quot;, &quot;--chdir=3D/opt/layerindex&quot=
;]<br>
+CMD [&quot;/bin/sh&quot;, &quot;-c&quot;, &quot;/usr/local/bin/gunicorn ws=
gi:application --workers=3D4 --bind=3D:5000 --timeout=3D60 --log-level=3Dde=
bug --chdir=3D${APP_DIR}/layerindex&quot;]<br>
diff --git a/docker/migrate.sh b/docker/migrate.sh<br>
index ca15368..bb9f646 100755<br>
--- a/docker/migrate.sh<br>
+++ b/docker/migrate.sh<br>
@@ -1,2 +1,2 @@<br>
=C2=A0#!/bin/bash<br>
-python3 /opt/layerindex/manage.py migrate &quot;$@&quot;<br>
+python3 ${APP_DIR:-/opt}/layerindex/manage.py migrate &quot;$@&quot;<br>
diff --git a/docker/refreshlayers.sh b/docker/refreshlayers.sh<br>
index 0c550bd..5adaf86 100755<br>
--- a/docker/refreshlayers.sh<br>
+++ b/docker/refreshlayers.sh<br>
@@ -1,3 +1,3 @@<br>
=C2=A0#!/bin/bash<br>
-update=3D/opt/layerindex/layerindex/update.py<br>
+update=3D${APP_DIR:-/opt}/layerindex/layerindex/update.py<br>
=C2=A0$update -q -r<br>
diff --git a/docker/updatelayers.sh b/docker/updatelayers.sh<br>
index 21640ba..6f0e8f0 100755<br>
--- a/docker/updatelayers.sh<br>
+++ b/docker/updatelayers.sh<br>
@@ -1,3 +1,3 @@<br>
=C2=A0#!/bin/bash<br>
-update=3D/opt/layerindex/layerindex/update.py<br>
+update=3D${APP_DIR:-/opt}/layerindex/layerindex/update.py<br>
=C2=A0$update -q<br>
diff --git a/dockersetup.py b/dockersetup.py<br>
index bc7478c..3a74eb3 100755<br>
--- a/dockersetup.py<br>
+++ b/dockersetup.py<br>
@@ -70,6 +70,7 @@ def get_args():<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(&#39;--no-migrate&#39;, action=3D&q=
uot;store_true&quot;, default=3DFalse, help=3D&#39;Skip running database mi=
grations&#39;)<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(&#39;--no-admin-user&#39;, action=
=3D&quot;store_true&quot;, default=3DFalse, help=3D&#39;Skip adding admin u=
ser&#39;)<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(&#39;--no-connectivity&#39;, action=
=3D&quot;store_true&quot;, default=3DFalse, help=3D&#39;Skip checking exter=
nal network connectivity&#39;)<br>
+=C2=A0 =C2=A0 parser.add_argument(&#39;--app-dir&#39;, type=3Dstr, help=3D=
&#39;Base directory inside the container for application files. Default is =
%(default)s&#39;, required=3DFalse, default=3D&#39;/opt&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0args =3D parser.parse_args()<br>
<br>
@@ -253,14 +254,16 @@ def yaml_comment(line):<br>
<br>
<br>
=C2=A0# Add hostname, secret key, db info, and email host in docker-compose=
.yml<br>
-def edit_dockercompose(hostname, dbpassword, dbapassword, secretkey, rmqpa=
ssword, portmapping, letsencrypt, email_host, email_port, email_user, email=
_password, email_ssl, email_tls):<br>
+def edit_dockercompose(hostname, dbpassword, dbapassword, secretkey, rmqpa=
ssword, portmapping, letsencrypt, email_host, email_port, email_user, email=
_password, email_ssl, email_tls, app_dir=3D&#39;/opt&#39;):<br>
+<br>
+=C2=A0 =C2=A0 in_layersapp_build =3D False<br>
<br>
=C2=A0 =C2=A0 =C2=A0def adjust_cert_mount_line(ln):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0linesplit =3D ln.split(&#39;:&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if letsencrypt:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0linesplit[1] =3D &#39;/etc/=
letsencrypt&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linesplit[1] =3D &#39;/opt/cert&=
#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linesplit[1] =3D app_dir + &#39;=
/cert&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# This allows us to handle if there is a =
&quot;:ro&quot; or similar on the end<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &#39;:&#39;.join(linesplit)<br>
<br>
@@ -305,6 +308,33 @@ def edit_dockercompose(hostname, dbpassword, dbapasswo=
rd, secretkey, rmqpassword<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newlines.appe=
nd(ucline + &#39;\n&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newlines.appe=
nd(yaml_comment(line) + &#39;\n&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif re.match(r&#39;^\s+build:\s+\.$&#39;, lin=
e):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Convert inline &#39;build: .&#=
39; to block form so we can pass APP_DIR as a build arg<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indent =3D line[:len(line) - len=
(line.lstrip())]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newlines.append(indent + &#39;bu=
ild:\n&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newlines.append(indent + &#39;=
=C2=A0 context: .\n&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newlines.append(indent + &#39;=
=C2=A0 args:\n&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newlines.append(indent + &#39;=
=C2=A0 =C2=A0 - APP_DIR=3D${APP_DIR}\n&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in_layersapp_build =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif &#39;- APP_DIR=3D&#39; in line:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Keep APP_DIR referencing the .=
env file (do not embed value here)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format =3D line[:line.find(&#39;=
- APP_DIR=3D&#39;)].replace(&#39;#&#39;, &#39;&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newlines.append(format + &#39;- =
APP_DIR=3D${APP_DIR}\n&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif re.match(r&#39;^\s+context:\s+\.$&#39;, l=
ine) and in_layersapp_build:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in_layersapp_build =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newlines.append(line + &#39;\n&#=
39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif &#39;:/opt/workdir&#39; in line:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newlines.append(line.replace(&#3=
9;:/opt/workdir&#39;, &#39;:&#39; + app_dir + &#39;/workdir&#39;) + &#39;\n=
&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif &#39;:/opt/layerindex-task-logs&#39; in l=
ine:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newlines.append(line.replace(&#3=
9;:/opt/layerindex-task-logs&#39;, &#39;:&#39; + app_dir + &#39;/layerindex=
-task-logs&#39;) + &#39;\n&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif &#39;--workdir=3D/opt/layerindex&#39; in =
line:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newlines.append(line.replace(&#3=
9;--workdir=3D/opt/layerindex&#39;, &#39;--workdir=3D&#39; + app_dir + &#39=
;/layerindex&#39;) + &#39;\n&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif &quot;layersweb:&quot; in line:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in_layersweb =3D True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newlines.append(line + &quo=
t;\n&quot;)<br>
@@ -426,7 +456,7 @@ def edit_nginx_ssl_conf(hostname, https_port, certdir, =
certfile, keyfile):<br>
=C2=A0 =C2=A0 =C2=A0writefile(&quot;docker/nginx-ssl-edited.conf&quot;, &#3=
9;&#39;.join(newlines))<br>
<br>
<br>
-def edit_settings_py(emailaddr):<br>
+def edit_settings_py(emailaddr, app_dir=3D&#39;/opt&#39;):<br>
=C2=A0 =C2=A0 =C2=A0filedata =3D readfile(&#39;docker/settings.py&#39;)<br>
=C2=A0 =C2=A0 =C2=A0newlines =3D []<br>
=C2=A0 =C2=A0 =C2=A0lines =3D filedata.splitlines()<br>
@@ -444,6 +474,9 @@ def edit_settings_py(emailaddr):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newlines.appe=
nd(&quot;=C2=A0 (&#39;Admin&#39;, &#39;%s&#39;),\n&quot; % emailaddr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newlines.append(&quot;)\n&q=
uot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif line.lstrip().startswith(&#39;LAYER_FETCH=
_DIR&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newlines.append(&quot;LAYER_FETC=
H_DIR =3D \&quot;%s/workdir\&quot;\n&quot; % app_dir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newlines.append(line + &quot;\n&quot;)<br=
>
=C2=A0 =C2=A0 =C2=A0writefile(&quot;docker/settings.py&quot;, &#39;&#39;.jo=
in(newlines))<br>
<br>
@@ -474,9 +507,9 @@ def edit_dockerfile_web(hostname, no_https):<br>
=C2=A0 =C2=A0 =C2=A0writefile(&quot;Dockerfile.web&quot;, &#39;&#39;.join(n=
ewlines))<br>
<br>
<br>
-def setup_https(hostname, http_port, https_port, letsencrypt, letsencrypt_=
production, cert, cert_key, emailaddr):<br>
+def setup_https(hostname, http_port, https_port, letsencrypt, letsencrypt_=
production, cert, cert_key, emailaddr, app_dir=3D&#39;/opt&#39;):<br>
=C2=A0 =C2=A0 =C2=A0local_cert_dir =3D os.path.abspath(&#39;docker/certs&#3=
9;)<br>
-=C2=A0 =C2=A0 container_cert_dir =3D &#39;/opt/cert&#39;<br>
+=C2=A0 =C2=A0 container_cert_dir =3D app_dir + &#39;/cert&#39;<br>
=C2=A0 =C2=A0 =C2=A0if letsencrypt:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Create dummy cert<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0container_cert_dir =3D &#39;/etc/letsencr=
ypt&#39;<br>
@@ -578,8 +611,26 @@ def edit_options_file(project_name):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(&#39;project_name=3D%s\n&#39; % p=
roject_name)<br>
<br>
<br>
-def check_connectivity():<br>
-=C2=A0 =C2=A0 return_code =3D subprocess.call([&#39;docker-compose&#39;, &=
#39;run&#39;, &#39;--rm&#39;, &#39;layersapp&#39;, &#39;/opt/connectivity_c=
heck.sh&#39;], shell=3DFalse)<br>
+def write_env_file(app_dir):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Write APP_DIR to .env so docker-compose pa=
sses it as a build arg.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 env_vars =3D {}<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(&#39;.env&#39;, &#39;r&#39;) as f:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D line.stri=
p()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;=3D&#39; i=
n line and not line.startswith(&#39;#&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 k, v=
 =3D line.split(&#39;=3D&#39;, 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env_=
vars[k.strip()] =3D v.strip()<br>
+=C2=A0 =C2=A0 except FileNotFoundError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
+=C2=A0 =C2=A0 env_vars[&#39;APP_DIR&#39;] =3D app_dir<br>
+=C2=A0 =C2=A0 with open(&#39;.env&#39;, &#39;w&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for k, v in env_vars.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&#39;%s=3D%s\n&#39; % (k=
, v))<br>
+<br>
+<br>
+def check_connectivity(app_dir=3D&#39;/opt&#39;):<br>
+=C2=A0 =C2=A0 return_code =3D subprocess.call([&#39;docker-compose&#39;, &=
#39;run&#39;, &#39;--rm&#39;, &#39;layersapp&#39;, app_dir + &#39;/connecti=
vity_check.sh&#39;], shell=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0if return_code !=3D 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;Connectivity check failed - i=
f you are behind a proxy, please check that you have correctly specified th=
e proxy settings on the command line (see --help for details)&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
@@ -741,24 +792,25 @@ if args.uninstall:<br>
=C2=A0if args.update:<br>
=C2=A0 =C2=A0 =C2=A0args.no_https =3D read_dockerfile_web()<br>
=C2=A0 =C2=A0 =C2=A0if not args.no_https:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 container_cert_dir =3D &#39;/opt/cert&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 container_cert_dir =3D args.app_dir + &#39;/ce=
rt&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.hostname, https_port, certdir, certf=
ile, keyfile =3D read_nginx_ssl_conf(container_cert_dir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0edit_nginx_ssl_conf(args.hostname, https_=
port, certdir, certfile, keyfile)<br>
=C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0# Always edit these in case we switch from proxy to no =
proxy<br>
=C2=A0 =C2=A0 =C2=A0edit_gitproxy(socks_proxy_host, socks_proxy_port, args.=
no_proxy)<br>
=C2=A0 =C2=A0 =C2=A0edit_dockerfile(args.http_proxy, args.https_proxy, args=
.no_proxy)<br>
+=C2=A0 =C2=A0 write_env_file(args.app_dir)<br>
<br>
-=C2=A0 =C2=A0 edit_dockercompose(args.hostname, dbpassword, dbapassword, s=
ecretkey, rmqpassword, args.portmapping, args.letsencrypt, email_host, emai=
l_port, args.email_user, args.email_password, args.email_ssl, args.email_tl=
s)<br>
+=C2=A0 =C2=A0 edit_dockercompose(args.hostname, dbpassword, dbapassword, s=
ecretkey, rmqpassword, args.portmapping, args.letsencrypt, email_host, emai=
l_port, args.email_user, args.email_password, args.email_ssl, args.email_tl=
s, args.app_dir)<br>
<br>
=C2=A0 =C2=A0 =C2=A0edit_dockerfile_web(args.hostname, args.no_https)<br>
<br>
-=C2=A0 =C2=A0 edit_settings_py(emailaddr)<br>
+=C2=A0 =C2=A0 edit_settings_py(emailaddr, args.app_dir)<br>
<br>
=C2=A0 =C2=A0 =C2=A0edit_options_file(args.project_name)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if not args.no_https:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 setup_https(args.hostname, http_port, https_po=
rt, args.letsencrypt, args.letsencrypt_production, args.cert, args.cert_key=
, emailaddr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 setup_https(args.hostname, http_port, https_po=
rt, args.letsencrypt, args.letsencrypt_production, args.cert, args.cert_key=
, emailaddr, args.app_dir)<br>
<br>
=C2=A0## Start up containers<br>
=C2=A0return_code =3D subprocess.call([&#39;docker-compose&#39;, &#39;up&#3=
9;, &#39;-d&#39;, &#39;--build&#39;], shell=3DFalse)<br>
@@ -768,7 +820,7 @@ if return_code !=3D 0:<br>
<br>
=C2=A0if not (args.update or args.no_connectivity):<br>
=C2=A0 =C2=A0 =C2=A0## Run connectivity check<br>
-=C2=A0 =C2=A0 check_connectivity()<br>
+=C2=A0 =C2=A0 check_connectivity(args.app_dir)<br>
<br>
=C2=A0# Get real project name (if only there were a reasonable way to do th=
is... ugh)<br>
=C2=A0real_project_name =3D &#39;&#39;<br>
@@ -830,7 +882,7 @@ if not args.no_migrate:<br>
=C2=A0 =C2=A0 =C2=A0env =3D os.environ.copy()<br>
=C2=A0 =C2=A0 =C2=A0env[&#39;DATABASE_USER&#39;] =3D &#39;root&#39;<br>
=C2=A0 =C2=A0 =C2=A0env[&#39;DATABASE_PASSWORD&#39;] =3D dbapassword<br>
-=C2=A0 =C2=A0 return_code =3D subprocess.call([&#39;docker-compose&#39;, &=
#39;run&#39;, &#39;--rm&#39;, &#39;-e&#39;, &#39;DATABASE_USER&#39;, &#39;-=
e&#39;, &#39;DATABASE_PASSWORD&#39;, &#39;layersapp&#39;, &#39;/opt/migrate=
.sh&#39;], shell=3DFalse, env=3Denv)<br>
+=C2=A0 =C2=A0 return_code =3D subprocess.call([&#39;docker-compose&#39;, &=
#39;run&#39;, &#39;--rm&#39;, &#39;-e&#39;, &#39;DATABASE_USER&#39;, &#39;-=
e&#39;, &#39;DATABASE_PASSWORD&#39;, &#39;layersapp&#39;, args.app_dir + &#=
39;/migrate.sh&#39;], shell=3DFalse, env=3Denv)<br>
=C2=A0 =C2=A0 =C2=A0if return_code !=3D 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;Applying migrations failed&qu=
ot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
@@ -864,13 +916,13 @@ if not args.update:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>
=C2=A0 =C2=A0 =C2=A0for volume in volumes:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0volname =3D &#39;%s_%s&#39; % (real_proje=
ct_name, volume)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_code =3D subprocess.call([&#39;docker&#=
39;, &#39;run&#39;, &#39;--rm&#39;, &#39;-v&#39;, &#39;%s:/opt/mount&#39; %=
 volname, &#39;debian:stretch&#39;, &#39;chown&#39;, &#39;500&#39;, &#39;/o=
pt/mount&#39;], shell=3DFalse)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_code =3D subprocess.call([&#39;docker&#=
39;, &#39;run&#39;, &#39;--rm&#39;, &#39;-v&#39;, &#39;%s:%s/mount&#39; % (=
volname, args.app_dir), &#39;debian:stretch&#39;, &#39;chown&#39;, &#39;500=
&#39;, args.app_dir + &#39;/mount&#39;], shell=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if return_code !=3D 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;Setting volume =
permissions for volume %s failed&quot; % volume)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
<br>
=C2=A0## Generate static assets. Run this command again to regenerate at an=
y time (when static assets in the code are updated)<br>
-return_code =3D subprocess.call(&quot;docker-compose run --rm -e STATIC_RO=
OT=3D/usr/share/nginx/html -v %s_layersstatic:/usr/share/nginx/html layersa=
pp /opt/layerindex/manage.py collectstatic --noinput&quot; % quote(real_pro=
ject_name), shell =3D True)<br>
+return_code =3D subprocess.call(&quot;docker-compose run --rm -e STATIC_RO=
OT=3D/usr/share/nginx/html -v %s_layersstatic:/usr/share/nginx/html layersa=
pp %s/layerindex/manage.py collectstatic --noinput&quot; % (quote(real_proj=
ect_name), args.app_dir), shell =3D True)<br>
=C2=A0if return_code !=3D 0:<br>
=C2=A0 =C2=A0 =C2=A0print(&quot;Collecting static files failed&quot;)<br>
=C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
@@ -891,12 +943,12 @@ else:<br>
=C2=A0if not args.update:<br>
=C2=A0 =C2=A0 =C2=A0if not args.databasefile:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0## Set site name<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_code =3D subprocess.call([&#39;docker-c=
ompose&#39;, &#39;run&#39;, &#39;--rm&#39;, &#39;layersapp&#39;, &#39;/opt/=
layerindex/layerindex/tools/site_name.py&#39;, host, &#39;OpenEmbedded Laye=
r Index&#39;], shell=3DFalse)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_code =3D subprocess.call([&#39;docker-c=
ompose&#39;, &#39;run&#39;, &#39;--rm&#39;, &#39;layersapp&#39;, args.app_d=
ir + &#39;/layerindex/layerindex/tools/site_name.py&#39;, host, &#39;OpenEm=
bedded Layer Index&#39;], shell=3DFalse)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if not args.no_admin_user:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0## For a fresh database, create an admin =
account<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;Creating database superuser. =
Input user name and password when prompted.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_code =3D subprocess.call([&#39;docker-c=
ompose&#39;, &#39;run&#39;, &#39;--rm&#39;, &#39;layersapp&#39;, &#39;/opt/=
layerindex/manage.py&#39;, &#39;createsuperuser&#39;, &#39;--email&#39;, em=
ailaddr], shell=3DFalse)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_code =3D subprocess.call([&#39;docker-c=
ompose&#39;, &#39;run&#39;, &#39;--rm&#39;, &#39;layersapp&#39;, args.app_d=
ir + &#39;/layerindex/manage.py&#39;, &#39;createsuperuser&#39;, &#39;--ema=
il&#39;, emailaddr], shell=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if return_code !=3D 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;Creating superu=
ser failed&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000002db94b0653eabcb2--

