Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67198EB1071
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 15:45:20 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43227.1773157511373017863
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 08:45:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cW6BZoui;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd8dbf4f2eso213990785a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1773157510; x=1773762310; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0fH1SAo+rJpnLjwDHpxG71Z3n6CiQv3wEL7nG3pYHyc=;
        b=cW6BZoui1oogJJjcG51ujh9x5NfiUgy316HYlt6c8rj1kdzWuwV6786t6uCKZkg68T
         s1Ug5MTjIDU+pdY9IKCEDRhnvyXUD2f5YKtCbuHlxXKCBb2Ll/82gXkJVg88hrf1Rw1M
         Xo7B5r7XtFUWZMmTjx3LGVf1uOks+t7MPy79s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773157510; x=1773762310;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fH1SAo+rJpnLjwDHpxG71Z3n6CiQv3wEL7nG3pYHyc=;
        b=Y04K/MVwOaOcz7JFjWwUoiw4AoTd5zXaKZCnGHh85tvdUa/eg3JfI6AODHwfqaJD8j
         kSq2C3ZPKO1+jIJklx+WKeK5+B0qkTeoV74KW0JCiCTw6V3AvUK2X78rvURehNbVoNr8
         oiinvCnzbNtcj9dMLxQthI8uPJvGJv3Eo3y7NpRV/8uFV321lR3G1G9RRK5S8MvODUrj
         HUN/iidRUwwO7gqsZX9Cavv1xHq7Lsw6hvEw6KCPtmOH8uD91jA+tQnPrAQyggxFK5Sd
         vwHrxeEd8zzxGfuRulXkDwZPmsiI4sxDYmACbo3+5rqrENQl2lv+HKf/b6qqWtNPQ8Yu
         8Lwg==
X-Gm-Message-State: AOJu0Yy60X7Izm7wJYfnGiLyjIWzhnC2qPyLfV5BBIUrsiS0Q/cIjM5F
	a2gXxktb7ILGTd8lAhqrj28dmWpzWwu63eYmjaQljjKmwt0K9Gab2REk0yGaY2kBier1CxG0Rdh
	jr/l0eNs=
X-Gm-Gg: ATEYQzyEXRfGgcSUoG9RpdjR6nIujidI5scMC9N+sSK7mNuG6LlwjIGzqouRbB4+eh+
	QCuuB4uLVaTltRHE3o+T0N11PpeItmo1oybtcroVu73V6ykgScTq0QvSxBecZTGdjNxiyKYv9Rg
	TzwpgO0CDbMqpQfFUK74mpwcIFNWgnL13HWEm4xme+F3a+Vkl5hESIQxIKiTKLNCh5r5LOtu7Tk
	zzjFw0bJTc+B0vC5m06YKOrANqQe3VyupBd4eMa/AkDc4y0kZKEH5dkoU0kgSpQlpes37Z7t7/F
	3TzdUUQz1CFOSi6+YqZlWQKa3G7sW2u3But56hedkohvXCUZQd2OQYeyd1X71r51CQxWDlJ7jp7
	FsXvL1RUvFUssnX8i97wjYHSJ0NLfrmc82QiqcjozFyCdKAFKzkBzsj+7irHcBBgVRpacAKm5Ld
	JX5/58x0Mx5gzQGAWtggs8E5a7olWvWwMuM10V4PDDJmc9O6A6CTPC78ZU3gLV8xZZWyNvduRnX
	Hz5JiaIt1xdcfExc74JeFasGSMBbNezzuw++ySjxpLmQL0=
X-Received: by 2002:a05:622a:58e:b0:4f1:bdf7:1795 with SMTP id d75a77b69052e-508f46f8373mr201819391cf.22.1773157509946;
        Tue, 10 Mar 2026 08:45:09 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50923ed69bbsm30767421cf.28.2026.03.10.08.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:45:09 -0700 (PDT)
Date: Tue, 10 Mar 2026 11:45:08 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Martin Jansa <martin.jansa@gmail.com>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][kirkstone][PATCH 1/4] meta-security:
 move perl and python recipes to dynamic layers structure
In-Reply-To: <20260310102739.2743995-1-martin.jansa@gmail.com>
Message-ID: <cd091aba-6902-eda8-83b9-ade077fb881b@konsulko.com>
References: <20260310102739.2743995-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 15:45:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3395

On Tue, 10 Mar 2026, Martin Jansa via lists.yoctoproject.org wrote:

I'm curious what the motivation is to backport this with 2 months before
kirkstone EOL?

Thanks,

Scott

> From: Armin Kuster <akuster808@gmail.com>
>
> Signed-off-by: Armin Kuster <akuster808@gmail.com>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>  .../recipes-scanners/checksecurity/checksecurity_2.0.15.bb        | 0
>  .../files/check-setuid-use-more-portable-find-args.patch          | 0
>  .../meta-perl/recipes-security}/bastille/bastille_3.2.1.bb        | 0
>  .../meta-perl/recipes-security}/bastille/files/API.pm             | 0
>  .../recipes-security}/bastille/files/AccountPermission.pm         | 0
>  .../meta-perl/recipes-security}/bastille/files/FileContent.pm     | 0
>  .../meta-perl/recipes-security}/bastille/files/HPSpecific.pm      | 0
>  .../meta-perl/recipes-security}/bastille/files/Miscellaneous.pm   | 0
>  .../meta-perl/recipes-security}/bastille/files/ServiceAdmin.pm    | 0
>  .../bastille/files/accept_os_flag_in_backend.patch                | 0
>  .../recipes-security}/bastille/files/allow_os_with_assess.patch   | 0
>  .../recipes-security}/bastille/files/call_output_config.patch     | 0
>  .../meta-perl/recipes-security}/bastille/files/config             | 0
>  .../recipes-security}/bastille/files/do_not_apply_config.patch    | 0
>  .../recipes-security}/bastille/files/edit_usage_message.patch     | 0
>  .../recipes-security}/bastille/files/find_existing_config.patch   | 0
>  .../bastille/files/fix_missing_use_directives.patch               | 0
>  .../recipes-security}/bastille/files/fix_number_of_modules.patch  | 0
>  .../recipes-security}/bastille/files/fix_version_parse.patch      | 0
>  .../recipes-security}/bastille/files/fixed_defined_warnings.patch | 0
>  .../bastille/files/organize_distro_discovery.patch                | 0
>  .../bastille/files/remove_questions_text_file_references.patch    | 0
>  .../recipes-security}/bastille/files/set_required_questions.py    | 0
>  .../recipes-security}/bastille/files/simplify_B_place.patch       | 0
>  .../bastille/files/upgrade_options_processing.patch               | 0
>  .../meta-perl/recipes-security}/nikto/files/location.patch        | 0
>  .../meta-perl/recipes-security}/nikto/nikto_2.1.6.bb              | 0
>  .../fail2ban/files/0001-To-fix-build-error-of-xrang.patch         | 0
>  .../meta-python/recipes-security}/fail2ban/files/initd            | 0
>  .../meta-python/recipes-security}/fail2ban/files/run-ptest        | 0
>  .../recipes-security}/fail2ban/python3-fail2ban_0.11.2.bb         | 0
>  .../recipes-security}/mfa/python3-privacyidea_3.6.2.bb            | 0
>  .../recipes-security}/python/python3-oauth2client_4.1.3.bb        | 0
>  33 files changed, 0 insertions(+), 0 deletions(-)
>  rename recipes-scanners/checksecurity/checksecurity_2.0.16.bb => dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.15.bb (100%)
>  rename {recipes-scanners => dynamic-layers/meta-perl/recipes-scanners}/checksecurity/files/check-setuid-use-more-portable-find-args.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/bastille_3.2.1.bb (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/API.pm (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/AccountPermission.pm (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/FileContent.pm (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/HPSpecific.pm (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/Miscellaneous.pm (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/ServiceAdmin.pm (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/accept_os_flag_in_backend.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/allow_os_with_assess.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/call_output_config.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/config (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/do_not_apply_config.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/edit_usage_message.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/find_existing_config.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/fix_missing_use_directives.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/fix_number_of_modules.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/fix_version_parse.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/fixed_defined_warnings.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/organize_distro_discovery.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/remove_questions_text_file_references.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/set_required_questions.py (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/simplify_B_place.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/upgrade_options_processing.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/nikto/files/location.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/nikto/nikto_2.1.6.bb (100%)
>  rename {recipes-security => dynamic-layers/meta-python/recipes-security}/fail2ban/files/0001-To-fix-build-error-of-xrang.patch (100%)
>  rename {recipes-security => dynamic-layers/meta-python/recipes-security}/fail2ban/files/initd (100%)
>  rename {recipes-security => dynamic-layers/meta-python/recipes-security}/fail2ban/files/run-ptest (100%)
>  rename {recipes-security => dynamic-layers/meta-python/recipes-security}/fail2ban/python3-fail2ban_0.11.2.bb (100%)
>  rename {recipes-security => dynamic-layers/meta-python/recipes-security}/mfa/python3-privacyidea_3.6.2.bb (100%)
>  rename {recipes-python => dynamic-layers/meta-python/recipes-security}/python/python3-oauth2client_4.1.3.bb (100%)
>
> diff --git a/recipes-scanners/checksecurity/checksecurity_2.0.16.bb b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.15.bb
> similarity index 100%
> rename from recipes-scanners/checksecurity/checksecurity_2.0.16.bb
> rename to dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.15.bb
> diff --git a/recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch
> similarity index 100%
> rename from recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch
> rename to dynamic-layers/meta-perl/recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch
> diff --git a/recipes-security/bastille/bastille_3.2.1.bb b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
> similarity index 100%
> rename from recipes-security/bastille/bastille_3.2.1.bb
> rename to dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
> diff --git a/recipes-security/bastille/files/API.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/API.pm
> similarity index 100%
> rename from recipes-security/bastille/files/API.pm
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/API.pm
> diff --git a/recipes-security/bastille/files/AccountPermission.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/AccountPermission.pm
> similarity index 100%
> rename from recipes-security/bastille/files/AccountPermission.pm
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/AccountPermission.pm
> diff --git a/recipes-security/bastille/files/FileContent.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/FileContent.pm
> similarity index 100%
> rename from recipes-security/bastille/files/FileContent.pm
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/FileContent.pm
> diff --git a/recipes-security/bastille/files/HPSpecific.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/HPSpecific.pm
> similarity index 100%
> rename from recipes-security/bastille/files/HPSpecific.pm
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/HPSpecific.pm
> diff --git a/recipes-security/bastille/files/Miscellaneous.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/Miscellaneous.pm
> similarity index 100%
> rename from recipes-security/bastille/files/Miscellaneous.pm
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/Miscellaneous.pm
> diff --git a/recipes-security/bastille/files/ServiceAdmin.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/ServiceAdmin.pm
> similarity index 100%
> rename from recipes-security/bastille/files/ServiceAdmin.pm
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/ServiceAdmin.pm
> diff --git a/recipes-security/bastille/files/accept_os_flag_in_backend.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/accept_os_flag_in_backend.patch
> similarity index 100%
> rename from recipes-security/bastille/files/accept_os_flag_in_backend.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/accept_os_flag_in_backend.patch
> diff --git a/recipes-security/bastille/files/allow_os_with_assess.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/allow_os_with_assess.patch
> similarity index 100%
> rename from recipes-security/bastille/files/allow_os_with_assess.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/allow_os_with_assess.patch
> diff --git a/recipes-security/bastille/files/call_output_config.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/call_output_config.patch
> similarity index 100%
> rename from recipes-security/bastille/files/call_output_config.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/call_output_config.patch
> diff --git a/recipes-security/bastille/files/config b/dynamic-layers/meta-perl/recipes-security/bastille/files/config
> similarity index 100%
> rename from recipes-security/bastille/files/config
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/config
> diff --git a/recipes-security/bastille/files/do_not_apply_config.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/do_not_apply_config.patch
> similarity index 100%
> rename from recipes-security/bastille/files/do_not_apply_config.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/do_not_apply_config.patch
> diff --git a/recipes-security/bastille/files/edit_usage_message.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/edit_usage_message.patch
> similarity index 100%
> rename from recipes-security/bastille/files/edit_usage_message.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/edit_usage_message.patch
> diff --git a/recipes-security/bastille/files/find_existing_config.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/find_existing_config.patch
> similarity index 100%
> rename from recipes-security/bastille/files/find_existing_config.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/find_existing_config.patch
> diff --git a/recipes-security/bastille/files/fix_missing_use_directives.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/fix_missing_use_directives.patch
> similarity index 100%
> rename from recipes-security/bastille/files/fix_missing_use_directives.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/fix_missing_use_directives.patch
> diff --git a/recipes-security/bastille/files/fix_number_of_modules.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/fix_number_of_modules.patch
> similarity index 100%
> rename from recipes-security/bastille/files/fix_number_of_modules.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/fix_number_of_modules.patch
> diff --git a/recipes-security/bastille/files/fix_version_parse.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/fix_version_parse.patch
> similarity index 100%
> rename from recipes-security/bastille/files/fix_version_parse.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/fix_version_parse.patch
> diff --git a/recipes-security/bastille/files/fixed_defined_warnings.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/fixed_defined_warnings.patch
> similarity index 100%
> rename from recipes-security/bastille/files/fixed_defined_warnings.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/fixed_defined_warnings.patch
> diff --git a/recipes-security/bastille/files/organize_distro_discovery.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/organize_distro_discovery.patch
> similarity index 100%
> rename from recipes-security/bastille/files/organize_distro_discovery.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/organize_distro_discovery.patch
> diff --git a/recipes-security/bastille/files/remove_questions_text_file_references.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/remove_questions_text_file_references.patch
> similarity index 100%
> rename from recipes-security/bastille/files/remove_questions_text_file_references.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/remove_questions_text_file_references.patch
> diff --git a/recipes-security/bastille/files/set_required_questions.py b/dynamic-layers/meta-perl/recipes-security/bastille/files/set_required_questions.py
> similarity index 100%
> rename from recipes-security/bastille/files/set_required_questions.py
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/set_required_questions.py
> diff --git a/recipes-security/bastille/files/simplify_B_place.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/simplify_B_place.patch
> similarity index 100%
> rename from recipes-security/bastille/files/simplify_B_place.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/simplify_B_place.patch
> diff --git a/recipes-security/bastille/files/upgrade_options_processing.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/upgrade_options_processing.patch
> similarity index 100%
> rename from recipes-security/bastille/files/upgrade_options_processing.patch
> rename to dynamic-layers/meta-perl/recipes-security/bastille/files/upgrade_options_processing.patch
> diff --git a/recipes-security/nikto/files/location.patch b/dynamic-layers/meta-perl/recipes-security/nikto/files/location.patch
> similarity index 100%
> rename from recipes-security/nikto/files/location.patch
> rename to dynamic-layers/meta-perl/recipes-security/nikto/files/location.patch
> diff --git a/recipes-security/nikto/nikto_2.1.6.bb b/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
> similarity index 100%
> rename from recipes-security/nikto/nikto_2.1.6.bb
> rename to dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
> diff --git a/recipes-security/fail2ban/files/0001-To-fix-build-error-of-xrang.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-To-fix-build-error-of-xrang.patch
> similarity index 100%
> rename from recipes-security/fail2ban/files/0001-To-fix-build-error-of-xrang.patch
> rename to dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-To-fix-build-error-of-xrang.patch
> diff --git a/recipes-security/fail2ban/files/initd b/dynamic-layers/meta-python/recipes-security/fail2ban/files/initd
> similarity index 100%
> rename from recipes-security/fail2ban/files/initd
> rename to dynamic-layers/meta-python/recipes-security/fail2ban/files/initd
> diff --git a/recipes-security/fail2ban/files/run-ptest b/dynamic-layers/meta-python/recipes-security/fail2ban/files/run-ptest
> similarity index 100%
> rename from recipes-security/fail2ban/files/run-ptest
> rename to dynamic-layers/meta-python/recipes-security/fail2ban/files/run-ptest
> diff --git a/recipes-security/fail2ban/python3-fail2ban_0.11.2.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_0.11.2.bb
> similarity index 100%
> rename from recipes-security/fail2ban/python3-fail2ban_0.11.2.bb
> rename to dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_0.11.2.bb
> diff --git a/recipes-security/mfa/python3-privacyidea_3.6.2.bb b/dynamic-layers/meta-python/recipes-security/mfa/python3-privacyidea_3.6.2.bb
> similarity index 100%
> rename from recipes-security/mfa/python3-privacyidea_3.6.2.bb
> rename to dynamic-layers/meta-python/recipes-security/mfa/python3-privacyidea_3.6.2.bb
> diff --git a/recipes-python/python/python3-oauth2client_4.1.3.bb b/dynamic-layers/meta-python/recipes-security/python/python3-oauth2client_4.1.3.bb
> similarity index 100%
> rename from recipes-python/python/python3-oauth2client_4.1.3.bb
> rename to dynamic-layers/meta-python/recipes-security/python/python3-oauth2client_4.1.3.bb
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3391): https://lists.yoctoproject.org/g/yocto-patches/message/3391
> Mute This Topic: https://lists.yoctoproject.org/mt/118238217/2167468
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170805/2167468/856840347/xyzzy [scott.murray@konsulko.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

