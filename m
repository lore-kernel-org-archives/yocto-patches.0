Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC591C36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 23:54:56 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web10.54833.1742860492978663894
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Mar 2025 16:54:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=tdUQXBTe;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5b2472969so488043985a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Mar 2025 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1742860492; x=1743465292; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi5w3jATS3Pl04V15tsxbaK/VtW991DXWHE03V+ikdU=;
        b=tdUQXBTenylAAVJw/zZXTwOjEJD4c+xHKV53jOaGipOKRvjb2p1yU7OdK+gYhvvL+S
         9wwCXwvqVho85QcBhgKBZRu6cMjBDgRmdUyhphffnUudooDBZ8M3z82RnAZf5zP0ay9Y
         ubFaLYsvFhbiSSQkBzJGb2lSGbKUAZjw7CkfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742860492; x=1743465292;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi5w3jATS3Pl04V15tsxbaK/VtW991DXWHE03V+ikdU=;
        b=Q9qNEyeTWepuEeq6QZ4xa6p0IAtcoMqvjNsyDV9NiEwLRbJ4FFDkzPmUrpqi0pN8mK
         lIkYZjGJ2UwdD7ogp8PH98WHUdBH2h84Hy6NtD9zCnu+IGG7ALs56H/o/EEpQHoTL7AQ
         WX2MDqCziy4YAVjLyRRZoUQyne0Pc6N59a5yWj5BL7+W1o6Ok/oVH5zYwtchHAzYgeEU
         9XNP/gfmx9sdiq3RMKaoTbkK3UGi6sybsT6ntBs9ejZjebNFANhnppdVhq7VWqZNyyQb
         W3lm4TEinvHAEK6MI6bmceP02yl9BKjh3cWCwktlE6+h0jbfG6hxoab4ucrfmqXpZiI0
         5pFA==
X-Gm-Message-State: AOJu0Ywy71d1OBqEDnOmpj7dN5Ug4m2tHwKTXO3waAq4rLN7eU2zn7qU
	Fhpyz2S7Q6Cox7w+DdFOYxzjEpOKwO+BeDEiLEbiqyGEvsGxoRUmE3f+wvWUkZRLW/L9z3fSan9
	3
X-Gm-Gg: ASbGnctIX2Wm+ggh9RLgxf9CFep7SthRnA+QzXWQrY4KiiDEaNcwrPaxW+L9eB6AgsT
	7cYAzNwwuU8O3BqCrOgNB603t0iBCAtG3XBXchFI8urKmQomZWvmas8KyUcHaYghWvAG4pjFboy
	7GPsj37SDJdN23yfUK5pdVL2bjRJKpIYqm4ShuDzvmppzkuRSOT0njefjnjhm6NZ6t1N6mTdh7D
	2Og9Wncc4y6TOL9crBnoOV69+uwBl/x+8YaFiajC/34jH1b5xIhwPFqFWdr3UiQWwpvq9StZj1R
	GjhgGVuZsvySSA12kjXatqar3Ky4+OoPfupqpUb7UGCgolriRWXoPLwj4Bi2RAOAoZrqsnvLr1e
	jdhOzLKv8AvIpHg==
X-Google-Smtp-Source: AGHT+IE/y0p4EuL5gSYyW7iI2bUxqIMoA+r4UMy+2QVmpPXsiOen+5yW2pdn6zo/gmY8xurxtfLfFQ==
X-Received: by 2002:a05:620a:bc7:b0:7c5:5584:dc1b with SMTP id af79cd13be357-7c5ba2038famr2891841185a.54.1742860491604;
        Mon, 24 Mar 2025 16:54:51 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93487c3sm567701785a.67.2025.03.24.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 16:54:50 -0700 (PDT)
Date: Mon, 24 Mar 2025 19:54:35 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Vasileios Anagnostopoulos <vasileios.anagnostopoulos@siemens.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH] rust:
 use 'config.toml' instead of plain 'config'
In-Reply-To: <20250322093209.17389-1-vasileios.anagnostopoulos@siemens.com>
Message-ID: <4e159bff-1d2b-e2f9-8476-2f25ffb4dbe7@konsulko.com>
References: <20250322093209.17389-1-vasileios.anagnostopoulos@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Mar 2025 23:54:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1246

On Sat, 22 Mar 2025, Vasileios Anagnostopoulos via lists.yoctoproject.org wrote:

> cargo configuration has been renamed from 'config' to
> 'config.toml' in rust-1.38
>
> Using the old name is still supported but creates warnings like
>
> | $ cargo
> | warning: `/sdk.../home/cargo/config` is deprecated in favor of `config.toml`
> | note: if you need to support cargo 1.38 or earlier, you can symlink `config` to `config.toml`
>
> So use the new name to avoid the warnings
>
> Signed-off-by: Vasileios Anagnostopoulos <vasileios.anagnostopoulos@siemens.com>

There's a version of this in master branch already, it will get picked up
when I do the next set of backports, should be this week.

Scott


> ---
>  classes-recipe/cargo_common.bbclass           | 20 +++++++++----------
>  recipes-devtools/rust/rust-cross-canadian.inc | 14 ++++++-------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/classes-recipe/cargo_common.bbclass b/classes-recipe/cargo_common.bbclass
> index 26de947..c0f6544 100644
> --- a/classes-recipe/cargo_common.bbclass
> +++ b/classes-recipe/cargo_common.bbclass
> @@ -47,14 +47,14 @@ CARGO_RUST_TARGET_CCLD ??= "${RUST_TARGET_CCLD}"
>  cargo_common_do_configure () {
>  	mkdir -p ${CARGO_HOME}/bitbake
>
> -	cat <<- EOF > ${CARGO_HOME}/config
> +	cat <<- EOF > ${CARGO_HOME}/config.toml
>  	# EXTRA_OECARGO_PATHS
>  	paths = [
>  	$(for p in ${EXTRA_OECARGO_PATHS}; do echo \"$p\",; done)
>  	]
>  	EOF
>
> -	cat <<- EOF >> ${CARGO_HOME}/config
> +	cat <<- EOF >> ${CARGO_HOME}/config.toml
>
>  	# Local mirror vendored by bitbake
>  	[source.bitbake]
> @@ -62,7 +62,7 @@ cargo_common_do_configure () {
>  	EOF
>
>  	if [ ${CARGO_DISABLE_BITBAKE_VENDORING} = "0" ]; then
> -		cat <<- EOF >> ${CARGO_HOME}/config
> +		cat <<- EOF >> ${CARGO_HOME}/config.toml
>
>  		[source.crates-io]
>  		replace-with = "bitbake"
> @@ -70,7 +70,7 @@ cargo_common_do_configure () {
>  		EOF
>  	fi
>
> -	cat <<- EOF >> ${CARGO_HOME}/config
> +	cat <<- EOF >> ${CARGO_HOME}/config.toml
>
>  	[http]
>  	# Multiplexing can't be enabled because http2 can't be enabled
> @@ -82,7 +82,7 @@ cargo_common_do_configure () {
>
>  	EOF
>
> -	cat <<- EOF >> ${CARGO_HOME}/config
> +	cat <<- EOF >> ${CARGO_HOME}/config.toml
>
>  	# HOST_SYS
>  	[target.${RUST_HOST_SYS}]
> @@ -90,7 +90,7 @@ cargo_common_do_configure () {
>  	EOF
>
>  	if [ "${RUST_HOST_SYS}" != "${RUST_BUILD_SYS}" ]; then
> -		cat <<- EOF >> ${CARGO_HOME}/config
> +		cat <<- EOF >> ${CARGO_HOME}/config.toml
>
>  		# BUILD_SYS
>  		[target.${RUST_BUILD_SYS}]
> @@ -99,7 +99,7 @@ cargo_common_do_configure () {
>  	fi
>
>  	if [ "${RUST_TARGET_SYS}" != "${RUST_BUILD_SYS}" -a "${RUST_TARGET_SYS}" != "${RUST_HOST_SYS}" ]; then
> -		cat <<- EOF >> ${CARGO_HOME}/config
> +		cat <<- EOF >> ${CARGO_HOME}/config.toml
>
>  		# TARGET_SYS
>  		[target.${RUST_TARGET_SYS}]
> @@ -110,7 +110,7 @@ cargo_common_do_configure () {
>  	# Put build output in build directory preferred by bitbake instead of
>  	# inside source directory unless they are the same
>  	if [ "${B}" != "${S}" ]; then
> -		cat <<- EOF >> ${CARGO_HOME}/config
> +		cat <<- EOF >> ${CARGO_HOME}/config.toml
>
>  		[build]
>  		# Use out of tree build destination to avoid polluting the source tree
> @@ -118,7 +118,7 @@ cargo_common_do_configure () {
>  		EOF
>  	fi
>
> -	cat <<- EOF >> ${CARGO_HOME}/config
> +	cat <<- EOF >> ${CARGO_HOME}/config.toml
>
>  	[term]
>  	progress.when = 'always'
> @@ -129,7 +129,7 @@ cargo_common_do_configure () {
>  python cargo_common_do_patch_paths() {
>      import shutil
>
> -    cargo_config = os.path.join(d.getVar("CARGO_HOME"), "config")
> +    cargo_config = os.path.join(d.getVar("CARGO_HOME"), "config.toml")
>      if not os.path.exists(cargo_config):
>          return
>
> diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
> index af9f2d6..6525525 100644
> --- a/recipes-devtools/rust/rust-cross-canadian.inc
> +++ b/recipes-devtools/rust/rust-cross-canadian.inc
> @@ -72,13 +72,13 @@ do_install () {
>  	export CARGO_HOME="\$OECORE_TARGET_SYSROOT/home/cargo"
>  	mkdir -p "\$CARGO_HOME"
>          # Init the default target once, it might be otherwise user modified.
> -	if [ ! -f "\$CARGO_HOME/config" ]; then
> -		touch "\$CARGO_HOME/config"
> -		echo "[build]" >> "\$CARGO_HOME/config"
> -		echo 'target = "'${RUST_TARGET_SYS}'"' >> "\$CARGO_HOME/config"
> -		echo '# TARGET_SYS' >> "\$CARGO_HOME/config"
> -		echo '[target.'${RUST_TARGET_SYS}']' >> "\$CARGO_HOME/config"
> -		echo 'linker = "target-rust-ccld"' >> "\$CARGO_HOME/config"
> +	if [ ! -f "\$CARGO_HOME/config.toml" ]; then
> +		touch "\$CARGO_HOME/config.toml"
> +		echo "[build]" >> "\$CARGO_HOME/config.toml"
> +		echo 'target = "'${RUST_TARGET_SYS}'"' >> "\$CARGO_HOME/config.toml"
> +		echo '# TARGET_SYS' >> "\$CARGO_HOME/config.toml"
> +		echo '[target.'${RUST_TARGET_SYS}']' >> "\$CARGO_HOME/config.toml"
> +		echo 'linker = "target-rust-ccld"' >> "\$CARGO_HOME/config.toml"
>      fi
>
>  	# Keep the below off as long as HTTP/2 is disabled.
>

