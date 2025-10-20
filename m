Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96E4CCD199
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 17:11:34 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.web11.2867.1760980290335290827
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 10:11:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mXE02k26;
 spf=pass (domain: gmail.com, ip: 209.85.167.170, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-444b94983f7so524067b6e.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760980289; x=1761585089; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbTJhlNnKsKQW4iyRR9/JDKp02X5Qauu7jptSxPKrAs=;
        b=mXE02k26YCACXMsEmCOBAMFckhc30IvwMIwW//wDyQ0Cm+UwY4pgkL4PPm/8IAF62p
         etWLhpaI7a5bdxVXyewi8FYM66RfeuJ6LFIcD8mL3TgISKRrrc5wd1hQNQytvOGF7y4f
         9J9nVebq5EsY99vps69X6k24Noia0l89p3U20JYwLPERg/HcUQu8l8rVkzG5bdtKWydF
         1LRD7fSrBkG3V/ZKyhTNW4WHOyxVp6A3Y4+1DKzsLNuk8+Y4eOzH/MaoB0ZyZfedx674
         zLThbrWeHQAlNDZgivaipmAIWoXIOv9s4JUWI8emgBErBD+u4+KcHFSHhOjyeD0PYupR
         Xrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760980289; x=1761585089;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qbTJhlNnKsKQW4iyRR9/JDKp02X5Qauu7jptSxPKrAs=;
        b=KDYRtgRe3+q/mMn5oWfL5ArNAMXGFTF1/H9gmwlIQj20uYYCUWRfpwFS4yRopIpwAR
         zjpIZnjitIQsye+GuWh1QRfwWlcmpwBi9hRiGDGJIab19XBi+AyTyoCZY40wue8ICUvC
         iuq6qkbBrE6urK6kWD35arlvfFOlP2Uyj5s30razyMySbBMFlS+NYKFEMgHrxvq/2sFx
         EDvmWAkClAQuaR3IP59nkgMWXySSXx7Y6Eg/MRKa/Z2F5d0ms7ZRri0gLWSs6p1pI994
         Bq1gimIIbDCPYPy7JTessNOcoOvI0jHwC6kCVU9BQ8j6bVFwiEzAGd+/C/b9iXcZZJ0v
         Epow==
X-Forwarded-Encrypted: i=1; AJvYcCUjleL2tbidDU4aj2GtTl3/R8grE8jlDpOIjZ+5mYCcQ/McKKSUa7fJAcqVGi2o6yMln+/eX3ycIqC8EJCY@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxJiiFXMoUMxeqCN2TxVpUOLbGee0HME63I7MbQvT6RA5pwWSE5
	iL6DZoF9ZVQhbGTjnWsH5nRl0hdd2A27XOb0aBnyqTLzjH/8sR5yHFnx
X-Gm-Gg: ASbGncviJy7Mjh3Xdzx8WF+tmg3z8abrYl9i84xQkNWG8OR8kyhWonRvXnlqVel24LA
	1dxnu7NilR3Lod9VhtgkwMivuWl48+ZBL+ykFo1cl7xGkIlfqh05CrnwY7QFXScy01EWGb2bD5f
	crP1Zl2t3S0BTvS11NEPwyPOaBKRVcaXswGMofQ4lW0wDY42eS7Rx3YlP0wuJQo8RSZIYNvIKBz
	DKnkqKWsUeZ6tv4Ey36q4PyKp6rDGEL8yvOdSPm2Zxc417bCJkTwgk9WcAJpioxhd4tOJbAA7hq
	H+96/lcs8KykOFglBCBrBi/zgiTTzgxnEwOPQCGiyKxIQdDWui0yod8+N59fB5PCFTKfic6x4sl
	ov1u/Qd+x9ZYhNfI5/l+rfy8x23rHSVjKYkrwuaa/CotG4znOFsg4x35wTnE3R66Mq3sycYWRy4
	czt1i0HZylOc4azmGU/o3niBXILkt/4cuegsRXcrwYokfuxSDOhSp/BTPxD34M46fa
X-Google-Smtp-Source: AGHT+IElUU9DrOXUKUxSVTVac3iOxDwvG8GWRmg5zR3ymRj2ZkmuDG7OelcFbTgNCN0NyI/azQ7jow==
X-Received: by 2002:a05:6808:4442:b0:441:8f74:f39 with SMTP id 5614622812f47-443a31e8d48mr6963412b6e.67.1760980289466;
        Mon, 20 Oct 2025 10:11:29 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-651d3af4863sm2117984eaf.9.2025.10.20.10.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 10:11:29 -0700 (PDT)
Message-ID: <4650d415-3fb1-4610-9042-b0ee65990330@gmail.com>
Date: Mon, 20 Oct 2025 11:11:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][walnascar][PATCH] refpolicy: ssh - allow sshd_t
 kernel_t:system module_request
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 17:11:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2368

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-ssh-allow-sshd_t-kernel_t-sy.patch | 53 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0062-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch

diff --git a/recipes-security/refpolicy/refpolicy/0062-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch b/recipes-security/refpolicy/refpolicy/0062-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch
new file mode 100644
index 0000000..5926e4f
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0062-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch
@@ -0,0 +1,53 @@
+From c4a3f53eb17ed483636456c0a7d6ac8b8e30a587 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Wed, 11 Jun 2025 07:51:24 -0600
+Subject: [PATCH] ssh: allow sshd_t kernel_t:system module_request
+
+type=PROCTITLE proctitle=sshd -G -f /etc/ssh/sshd_config
+
+type=SYSCALL arch=armeb syscall=socket per=PER_LINUX success=no
+exit=EAFNOSUPPORT(Address family not supported by protocol) a0=inet6
+a1=SOCK_DGRAM a2=ip a3=0x0 items=0 ppid=1333 pid=1334 auid=unset
+uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
+fsgid=root tty=(none) ses=unset comm=sshd exe=/usr/sbin/sshd
+subj=system_u:system_r:sshd_t:s0 key=(null)
+
+type=AVC avc:  denied  { module_request } for  pid=1334 comm=sshd
+kmod="net-pf-10" scontext=system_u:system_r:sshd_t:s0
+tcontext=system_u:system_r:kernel_t:s0 tclass=system
+
+--
+
+Issue background: https://access.redhat.com/solutions/6768131
+
+--
+
+Fedora:
+
+https://github.com/fedora-selinux/selinux-policy/blob/v41.43/policy/modules/services/ssh.if#L244
+
+$ sesearch -A --source sshd_t --target kernel_t --class system --perm module_request
+allow domain kernel_t:system module_request; [ domain_kernel_load_modules ]:True
+allow sshd_t kernel_t:system module_request;
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/e3d3cd244f048304af882f00c56f48c3820bfe8d]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/ssh.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/services/ssh.te b/policy/modules/services/ssh.te
+index 2d10ecb73..86fa0cf99 100644
+--- a/policy/modules/services/ssh.te
++++ b/policy/modules/services/ssh.te
+@@ -249,6 +249,7 @@ corecmd_exec_bin(sshd_t)
+ 
+ kernel_link_key(sshd_t)
+ kernel_search_key(sshd_t)
++kernel_request_load_module(sshd_t)
+ 
+ term_use_all_ptys(sshd_t)
+ term_setattr_all_ptys(sshd_t)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 7bcb03b..5cd8cd0 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -77,6 +77,7 @@ SRC_URI += " \
         file://0059-policy-modules-system-systemd-allow-systemd_generato.patch \
         file://0060-policy-modules-system-unconfined-allow-firewalld_t-u.patch \
         file://0061-policy-modules-services-chronyd-allow-chronyd_t-kern.patch \
+        file://0062-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

