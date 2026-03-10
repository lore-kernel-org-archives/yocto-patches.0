Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E970EB1046
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 10:28:01 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37045.1773138470652118510
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 03:27:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fAI8HCGJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b7c2788dso6579639f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773138469; x=1773743269; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kHJrdk0c1rCM6oD/rbVABPU1RSJcLwNjjvOk9+gWN4=;
        b=fAI8HCGJ+jJKCHat26h7QIqY0cT3FPVZAeQ32SEn+AQuPeOiScVsOhuScqz+ARkQVA
         fOoEjQG+cW57JO3dGzacfimpkQwc+FscYalzpsCMOkQ8gcWD9tZOTH7Nx6zwkVeImCwX
         slIiqZyHwsgY8DG1tW7+5Q4K1tE6VyhdnunCkIJzGQiag733E5kc/uKmj1FpVVZnQek5
         A6NQ0SQ3v7Scy9yDCYuOzVLtNCA3ngBVX1YaSkee6AJFoSEA8pVrj0ABTsOwPAUXdm0N
         RpD1XTAgRSjtWJIgbYcz6oBKet/6rJMpiLBndjn+Tg9opDPJljU/8lYJ8FymJMAUd+9W
         Q42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138469; x=1773743269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kHJrdk0c1rCM6oD/rbVABPU1RSJcLwNjjvOk9+gWN4=;
        b=VSNxZGN1ZF3uP61saI5CwsEH/mhf18FIeOMMp6yba0bwhIQJxPHskUVq2LrV9IeVtf
         4aF92n19ZsZST5hndSxurxs81aNWdNxpg/AlBs/dAWovaip/KZkSnqMBcCuJjpQppVcP
         qbvJu3Gfbap1qq5yP+5EDEZlE2kWWmFCBUUt29AXBc55Q/BMuyuDsWLER3gSLfAPXrKo
         zAzrB+6zc4vVPAJugna3/4AHUOIkrgaAEmKWRavwgvFx9qR5rV50GqRAHbfXsNHQWgns
         KumATvJ6fLDtV5LVVVZugJvDiDPjTw/zIvCRdWXBxEsSkHY5orvK4Y06NmFgTrjCeDou
         h7eQ==
X-Gm-Message-State: AOJu0YwXTyyEMrL0E8Kedeopy2CUICRxmOLWFaOq98b74XT/qejWkhBb
	yISXi8GEzyrllNSV//ief2ojzNwhyVYcD+u+sxqguHYfPHyPkClI3IgEkN/Th7EL
X-Gm-Gg: ATEYQzxoGoIIKKsQwWtOm/jKF4KkS3btheJomay4b2Llaa2L3v4w2D2a9Hu7/a+UNoY
	AIK+NdHHTCiJv0pTOlh61D0+XVFbFzmPFigGIb4Y0FGyjrKweEpyTCEMidEztfreOhUvPPde7jr
	omXkosHVyz1myFevY8nqUWgbwwZ2FVqzPuE+GZsedNauBSVsG3rNbG1kcLE+UTlBuj7ODGJJDVa
	THOwZ1YhF9be2R39cYEYi/C3+RDnQK9Rb0VsyksPwUQ1smdn/S775O/PDgntbk/Nzuw/6BhFUkb
	DmUmLzNMlhAlFJSJYDVPD4qfRJOnZfM5mqK5R2Zn+QUBmiNyVhuPEWRig/sjrVeIJnkjDZYXCD8
	u6Oj4szEcE9xD3YB9vTbPuJcenIdG048q9AsRjH70nuS3jkvUhyU9Lq4mUVxnRd9Y30mdpaU/iQ
	9Zsx8q5ILTVQ2yCiZIkK8B3LbLczgCaKlLdaBZ
X-Received: by 2002:a5d:64c9:0:b0:439:cee7:714f with SMTP id ffacd0b85a97d-439da86f5afmr25099605f8f.53.1773138468505;
        Tue, 10 Mar 2026 03:27:48 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm35715497f8f.0.2026.03.10.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:27:47 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Armin Kuster <akuster808@gmail.com>,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-security][kirkstone][PATCH 1/4] meta-security: move perl and python recipes to dynamic layers structure
Date: Tue, 10 Mar 2026 11:27:36 +0100
Message-ID: <20260310102739.2743995-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 10:28:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3391

From: Armin Kuster <akuster808@gmail.com>

Signed-off-by: Armin Kuster <akuster808@gmail.com>
Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 .../recipes-scanners/checksecurity/checksecurity_2.0.15.bb        | 0
 .../files/check-setuid-use-more-portable-find-args.patch          | 0
 .../meta-perl/recipes-security}/bastille/bastille_3.2.1.bb        | 0
 .../meta-perl/recipes-security}/bastille/files/API.pm             | 0
 .../recipes-security}/bastille/files/AccountPermission.pm         | 0
 .../meta-perl/recipes-security}/bastille/files/FileContent.pm     | 0
 .../meta-perl/recipes-security}/bastille/files/HPSpecific.pm      | 0
 .../meta-perl/recipes-security}/bastille/files/Miscellaneous.pm   | 0
 .../meta-perl/recipes-security}/bastille/files/ServiceAdmin.pm    | 0
 .../bastille/files/accept_os_flag_in_backend.patch                | 0
 .../recipes-security}/bastille/files/allow_os_with_assess.patch   | 0
 .../recipes-security}/bastille/files/call_output_config.patch     | 0
 .../meta-perl/recipes-security}/bastille/files/config             | 0
 .../recipes-security}/bastille/files/do_not_apply_config.patch    | 0
 .../recipes-security}/bastille/files/edit_usage_message.patch     | 0
 .../recipes-security}/bastille/files/find_existing_config.patch   | 0
 .../bastille/files/fix_missing_use_directives.patch               | 0
 .../recipes-security}/bastille/files/fix_number_of_modules.patch  | 0
 .../recipes-security}/bastille/files/fix_version_parse.patch      | 0
 .../recipes-security}/bastille/files/fixed_defined_warnings.patch | 0
 .../bastille/files/organize_distro_discovery.patch                | 0
 .../bastille/files/remove_questions_text_file_references.patch    | 0
 .../recipes-security}/bastille/files/set_required_questions.py    | 0
 .../recipes-security}/bastille/files/simplify_B_place.patch       | 0
 .../bastille/files/upgrade_options_processing.patch               | 0
 .../meta-perl/recipes-security}/nikto/files/location.patch        | 0
 .../meta-perl/recipes-security}/nikto/nikto_2.1.6.bb              | 0
 .../fail2ban/files/0001-To-fix-build-error-of-xrang.patch         | 0
 .../meta-python/recipes-security}/fail2ban/files/initd            | 0
 .../meta-python/recipes-security}/fail2ban/files/run-ptest        | 0
 .../recipes-security}/fail2ban/python3-fail2ban_0.11.2.bb         | 0
 .../recipes-security}/mfa/python3-privacyidea_3.6.2.bb            | 0
 .../recipes-security}/python/python3-oauth2client_4.1.3.bb        | 0
 33 files changed, 0 insertions(+), 0 deletions(-)
 rename recipes-scanners/checksecurity/checksecurity_2.0.16.bb => dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.15.bb (100%)
 rename {recipes-scanners => dynamic-layers/meta-perl/recipes-scanners}/checksecurity/files/check-setuid-use-more-portable-find-args.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/bastille_3.2.1.bb (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/API.pm (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/AccountPermission.pm (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/FileContent.pm (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/HPSpecific.pm (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/Miscellaneous.pm (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/ServiceAdmin.pm (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/accept_os_flag_in_backend.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/allow_os_with_assess.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/call_output_config.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/config (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/do_not_apply_config.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/edit_usage_message.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/find_existing_config.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/fix_missing_use_directives.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/fix_number_of_modules.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/fix_version_parse.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/fixed_defined_warnings.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/organize_distro_discovery.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/remove_questions_text_file_references.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/set_required_questions.py (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/simplify_B_place.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/bastille/files/upgrade_options_processing.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/nikto/files/location.patch (100%)
 rename {recipes-security => dynamic-layers/meta-perl/recipes-security}/nikto/nikto_2.1.6.bb (100%)
 rename {recipes-security => dynamic-layers/meta-python/recipes-security}/fail2ban/files/0001-To-fix-build-error-of-xrang.patch (100%)
 rename {recipes-security => dynamic-layers/meta-python/recipes-security}/fail2ban/files/initd (100%)
 rename {recipes-security => dynamic-layers/meta-python/recipes-security}/fail2ban/files/run-ptest (100%)
 rename {recipes-security => dynamic-layers/meta-python/recipes-security}/fail2ban/python3-fail2ban_0.11.2.bb (100%)
 rename {recipes-security => dynamic-layers/meta-python/recipes-security}/mfa/python3-privacyidea_3.6.2.bb (100%)
 rename {recipes-python => dynamic-layers/meta-python/recipes-security}/python/python3-oauth2client_4.1.3.bb (100%)

diff --git a/recipes-scanners/checksecurity/checksecurity_2.0.16.bb b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.15.bb
similarity index 100%
rename from recipes-scanners/checksecurity/checksecurity_2.0.16.bb
rename to dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.15.bb
diff --git a/recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch
similarity index 100%
rename from recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch
rename to dynamic-layers/meta-perl/recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch
diff --git a/recipes-security/bastille/bastille_3.2.1.bb b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
similarity index 100%
rename from recipes-security/bastille/bastille_3.2.1.bb
rename to dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
diff --git a/recipes-security/bastille/files/API.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/API.pm
similarity index 100%
rename from recipes-security/bastille/files/API.pm
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/API.pm
diff --git a/recipes-security/bastille/files/AccountPermission.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/AccountPermission.pm
similarity index 100%
rename from recipes-security/bastille/files/AccountPermission.pm
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/AccountPermission.pm
diff --git a/recipes-security/bastille/files/FileContent.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/FileContent.pm
similarity index 100%
rename from recipes-security/bastille/files/FileContent.pm
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/FileContent.pm
diff --git a/recipes-security/bastille/files/HPSpecific.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/HPSpecific.pm
similarity index 100%
rename from recipes-security/bastille/files/HPSpecific.pm
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/HPSpecific.pm
diff --git a/recipes-security/bastille/files/Miscellaneous.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/Miscellaneous.pm
similarity index 100%
rename from recipes-security/bastille/files/Miscellaneous.pm
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/Miscellaneous.pm
diff --git a/recipes-security/bastille/files/ServiceAdmin.pm b/dynamic-layers/meta-perl/recipes-security/bastille/files/ServiceAdmin.pm
similarity index 100%
rename from recipes-security/bastille/files/ServiceAdmin.pm
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/ServiceAdmin.pm
diff --git a/recipes-security/bastille/files/accept_os_flag_in_backend.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/accept_os_flag_in_backend.patch
similarity index 100%
rename from recipes-security/bastille/files/accept_os_flag_in_backend.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/accept_os_flag_in_backend.patch
diff --git a/recipes-security/bastille/files/allow_os_with_assess.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/allow_os_with_assess.patch
similarity index 100%
rename from recipes-security/bastille/files/allow_os_with_assess.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/allow_os_with_assess.patch
diff --git a/recipes-security/bastille/files/call_output_config.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/call_output_config.patch
similarity index 100%
rename from recipes-security/bastille/files/call_output_config.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/call_output_config.patch
diff --git a/recipes-security/bastille/files/config b/dynamic-layers/meta-perl/recipes-security/bastille/files/config
similarity index 100%
rename from recipes-security/bastille/files/config
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/config
diff --git a/recipes-security/bastille/files/do_not_apply_config.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/do_not_apply_config.patch
similarity index 100%
rename from recipes-security/bastille/files/do_not_apply_config.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/do_not_apply_config.patch
diff --git a/recipes-security/bastille/files/edit_usage_message.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/edit_usage_message.patch
similarity index 100%
rename from recipes-security/bastille/files/edit_usage_message.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/edit_usage_message.patch
diff --git a/recipes-security/bastille/files/find_existing_config.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/find_existing_config.patch
similarity index 100%
rename from recipes-security/bastille/files/find_existing_config.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/find_existing_config.patch
diff --git a/recipes-security/bastille/files/fix_missing_use_directives.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/fix_missing_use_directives.patch
similarity index 100%
rename from recipes-security/bastille/files/fix_missing_use_directives.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/fix_missing_use_directives.patch
diff --git a/recipes-security/bastille/files/fix_number_of_modules.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/fix_number_of_modules.patch
similarity index 100%
rename from recipes-security/bastille/files/fix_number_of_modules.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/fix_number_of_modules.patch
diff --git a/recipes-security/bastille/files/fix_version_parse.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/fix_version_parse.patch
similarity index 100%
rename from recipes-security/bastille/files/fix_version_parse.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/fix_version_parse.patch
diff --git a/recipes-security/bastille/files/fixed_defined_warnings.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/fixed_defined_warnings.patch
similarity index 100%
rename from recipes-security/bastille/files/fixed_defined_warnings.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/fixed_defined_warnings.patch
diff --git a/recipes-security/bastille/files/organize_distro_discovery.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/organize_distro_discovery.patch
similarity index 100%
rename from recipes-security/bastille/files/organize_distro_discovery.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/organize_distro_discovery.patch
diff --git a/recipes-security/bastille/files/remove_questions_text_file_references.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/remove_questions_text_file_references.patch
similarity index 100%
rename from recipes-security/bastille/files/remove_questions_text_file_references.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/remove_questions_text_file_references.patch
diff --git a/recipes-security/bastille/files/set_required_questions.py b/dynamic-layers/meta-perl/recipes-security/bastille/files/set_required_questions.py
similarity index 100%
rename from recipes-security/bastille/files/set_required_questions.py
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/set_required_questions.py
diff --git a/recipes-security/bastille/files/simplify_B_place.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/simplify_B_place.patch
similarity index 100%
rename from recipes-security/bastille/files/simplify_B_place.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/simplify_B_place.patch
diff --git a/recipes-security/bastille/files/upgrade_options_processing.patch b/dynamic-layers/meta-perl/recipes-security/bastille/files/upgrade_options_processing.patch
similarity index 100%
rename from recipes-security/bastille/files/upgrade_options_processing.patch
rename to dynamic-layers/meta-perl/recipes-security/bastille/files/upgrade_options_processing.patch
diff --git a/recipes-security/nikto/files/location.patch b/dynamic-layers/meta-perl/recipes-security/nikto/files/location.patch
similarity index 100%
rename from recipes-security/nikto/files/location.patch
rename to dynamic-layers/meta-perl/recipes-security/nikto/files/location.patch
diff --git a/recipes-security/nikto/nikto_2.1.6.bb b/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
similarity index 100%
rename from recipes-security/nikto/nikto_2.1.6.bb
rename to dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
diff --git a/recipes-security/fail2ban/files/0001-To-fix-build-error-of-xrang.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-To-fix-build-error-of-xrang.patch
similarity index 100%
rename from recipes-security/fail2ban/files/0001-To-fix-build-error-of-xrang.patch
rename to dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-To-fix-build-error-of-xrang.patch
diff --git a/recipes-security/fail2ban/files/initd b/dynamic-layers/meta-python/recipes-security/fail2ban/files/initd
similarity index 100%
rename from recipes-security/fail2ban/files/initd
rename to dynamic-layers/meta-python/recipes-security/fail2ban/files/initd
diff --git a/recipes-security/fail2ban/files/run-ptest b/dynamic-layers/meta-python/recipes-security/fail2ban/files/run-ptest
similarity index 100%
rename from recipes-security/fail2ban/files/run-ptest
rename to dynamic-layers/meta-python/recipes-security/fail2ban/files/run-ptest
diff --git a/recipes-security/fail2ban/python3-fail2ban_0.11.2.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_0.11.2.bb
similarity index 100%
rename from recipes-security/fail2ban/python3-fail2ban_0.11.2.bb
rename to dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_0.11.2.bb
diff --git a/recipes-security/mfa/python3-privacyidea_3.6.2.bb b/dynamic-layers/meta-python/recipes-security/mfa/python3-privacyidea_3.6.2.bb
similarity index 100%
rename from recipes-security/mfa/python3-privacyidea_3.6.2.bb
rename to dynamic-layers/meta-python/recipes-security/mfa/python3-privacyidea_3.6.2.bb
diff --git a/recipes-python/python/python3-oauth2client_4.1.3.bb b/dynamic-layers/meta-python/recipes-security/python/python3-oauth2client_4.1.3.bb
similarity index 100%
rename from recipes-python/python/python3-oauth2client_4.1.3.bb
rename to dynamic-layers/meta-python/recipes-security/python/python3-oauth2client_4.1.3.bb

