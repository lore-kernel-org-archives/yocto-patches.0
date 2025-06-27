Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65742C77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 15:09:28 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web11.16221.1751036966079152805
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 08:09:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WIX68CLC;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fafdd322d3so27344396d6.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 08:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751036965; x=1751641765; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSw9p0Q0ZoNFR17yEDLXQLJQl2+XCL9iuBcmw+hAo60=;
        b=WIX68CLCpS+Fs5YNHblvCOREBi9RW1lHhxcKDTTykhpSvXo9WX4SC/8xde96DKOZgV
         vAj/tWgMEPwxKB9mj8NT3L1NfUItIuPPPVjef1kj5dj9/DJLwzw/kJ8JyhjrQrzxY+zm
         jDUUQPAWobGTobGd+mILonEbU9RNElEFO7/Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036965; x=1751641765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSw9p0Q0ZoNFR17yEDLXQLJQl2+XCL9iuBcmw+hAo60=;
        b=uMVb3X1hqN+gXSYpJwsxrieOcAC9cDh7mk4wkfOqAzUzit4ojFXgLt6iI9ulW7N3ca
         zBSttBNOJiz9Tc9kFAjsdH9mv7bT3e+eTbLYTf6AmFDuQ9m+gqSLo+SnHIFe8+N0+TSB
         x11gvN4m5j92zubaacES9t3mii2iSqvjG0+OmVO0o/jSzkZBW7XqOFGexIqXimDwU/I7
         dIzGlL7OofvezTEgCzrdo10OnbRPQLG1EAjIADhK5+HuluL4TkfhEgqLR9UJk9A2aruT
         VwFSiL4t8vt3OYBfNutew9ljUoxSJH6pc63yyE9KM8D7FdO9xDijTFYepKREclfdf+cG
         r5+A==
X-Gm-Message-State: AOJu0Yxz/ylgu01aDbcUQGRFLSuLFIHQA5n6ZNEEQcgh10FZOLpiT0em
	DTqTIVz2X0Wy4k2hKzxGy0qPBSSAIZt1VpMjKvVGDy3hiTiFRiXFEgHW/GVb+aajJ0aFCNEppwb
	EUYsK
X-Gm-Gg: ASbGncuo50h8lGkDXDhVnpfCpPP6o6I438+dGp63CVlVz2KDU+yFw4kUvRvG7+78OWN
	8UqHZ8OJxcb1vtEwxpognQ/4Qu299F9erEJy2MXhLmS2pn4A1Nzftu4F0fIFfyBKNeZqONsjNLX
	P407TTQ9Chwe1EQ4zDk3RN7jCgbS18fMVwitd4UjUq1FXfSul5BkM2GY8KtapxZpLS8o1MVsc9c
	c6gtpgijZYoE6HKKZqsPHk7UB5IHtD6BOg40BsCNhtzYp9e/lZkER7NzA5XJRPlSlYvIfXCpUPV
	xIIyC1MHZTPdTxt/zZ/eSepV8Tu6MDc7rRCPswQJX52KVAXBDOTM5eUoWhw+4yGdWImp2AlI/2a
	Ezzr58oTrkiI9wY88KvfvIucNRC6uoBJvV/jgLg==
X-Google-Smtp-Source: AGHT+IGZ5wUd5cFDvkG18WpOcIEYjcnavlWDl0S8wRFZ5lV3OT5/pqbWGTThuUEQip+iHSm+fAYK5Q==
X-Received: by 2002:ad4:5ca5:0:b0:6fa:ce87:2320 with SMTP id 6a1803df08f44-70002a0d0d3mr59040446d6.33.1751036964589;
        Fri, 27 Jun 2025 08:09:24 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718e76esm22003636d6.12.2025.06.27.08.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:23 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
Subject: [meta-selinux][PATCH v2 0/2] Updates to fix building with oe-core master branch
Date: Fri, 27 Jun 2025 11:09:13 -0400
Message-ID: <cover.1751036759.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 15:09:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1720

A couple of patches to handle the switch to whinlatter and adapt
the recipes for the subsequent S/UNPACKDIR changes.

v2:
Updated patch 0002 commit message to document adding default S
definition to selinux_common.inc.

Scott Murray (2):
  Set compatible layers to whinlatter
  Adapt to UNPACKDIR changes

 conf/layer.conf                                     | 2 +-
 recipes-security/refpolicy/refpolicy_common.inc     | 2 +-
 recipes-security/selinux-scripts/selinux-initsh.inc | 3 +--
 recipes-security/selinux/checkpolicy_3.8.1.bb       | 2 --
 recipes-security/selinux/libselinux-python_3.8.1.bb | 2 +-
 recipes-security/selinux/libselinux_3.8.1.bb        | 2 --
 recipes-security/selinux/libsemanage_3.8.1.bb       | 2 --
 recipes-security/selinux/libsepol_3.8.1.bb          | 2 --
 recipes-security/selinux/mcstrans_3.8.1.bb          | 2 --
 recipes-security/selinux/policycoreutils_3.8.1.bb   | 2 --
 recipes-security/selinux/restorecond_3.8.1.bb       | 2 --
 recipes-security/selinux/secilc_3.8.1.bb            | 2 --
 recipes-security/selinux/selinux-dbus_3.8.1.bb      | 2 +-
 recipes-security/selinux/selinux-gui_3.8.1.bb       | 2 +-
 recipes-security/selinux/selinux-python_3.8.1.bb    | 2 +-
 recipes-security/selinux/selinux-sandbox_3.8.1.bb   | 2 +-
 recipes-security/selinux/selinux_common.inc         | 2 ++
 recipes-security/selinux/semodule-utils_3.8.1.bb    | 2 --
 recipes-security/setools/setools_4.5.1.bb           | 2 --
 19 files changed, 10 insertions(+), 29 deletions(-)

-- 
2.49.0


