Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDDAC44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 10:23:17 +0000 (UTC)
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6030.1784542994321261719
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jul 2026 03:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=y4BSQPrN;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=DUZAQStU;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.150, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 662C8EC0080;
	Mon, 20 Jul 2026 06:23:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 20 Jul 2026 06:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1784542993; x=1784629393; bh=sp
	nu8GRF7p9ZVsOdSYCPzwtXKweendK8Ezb0vNbvBGI=; b=y4BSQPrNqoR/U+J8ps
	dsVDAV129rPS2gU2WN9xDiamJnt3C94sv+WY/NoMxtoqiDNph1z/bYAetTL3Zgsv
	LDQxEVk8z3D/nJS6ShlVBfobyhv48wby4M4Z5oeSoF/lOcvMMamhp9iuGjFyeT/H
	3un8RBow/dZSRNzmAoWmrhicjJtqDwh8asJ2labYjqGdrdgNceoZEpaBqi8LVwlG
	wxmh0t5SAn8TAflrSf8tQYtOoKQdYg15pnGOWkoDplMEuzY3UhyN/mtoOvounmjd
	bCjYYaDwvMuiwso7HdgShLfFvCsINX6jqALOldrSjzDh1ltSSWj28P+nJN4+qymW
	gV1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784542993; x=1784629393; bh=spnu8GRF7p9ZVsOdSYCPzwtXKwee
	ndK8Ezb0vNbvBGI=; b=DUZAQStUtNnAz/CJLqjDN4DG1vdG02sxEj0g1gsBMoDQ
	glO9+LhIfYg8AkYEAtqEDF67gIzJypryjZ9kKEduivMezd/vE81EHwDuDFJtQ5zU
	Gv24uFRxft5OUPBvWWr7VCuZececQAdylO3GPMjRTT8R9eOp0P1esi4GY+1pgXXn
	By9nQTwXiMHjkVl2IVd4ykKc3JokjINlqcVpXI6OsVTI75I2OOadap0ZVdFggxL8
	9839ESHtBBJM2C3X3O+tiR9DSo6yId6GKLwy6ogyTfYY10s30YhsUdWz7bkZgaRU
	BLdGnKJ5STYIMMFWZLc9VgihURiZzjGbEQ0mouscoA==
X-ME-Sender: <xms:EfddaiaBeSrup1VzkwFfvhdlEwAKhFbj7x3Kv4fnQaCwvbq-79Jugw>
    <xme:EfddarbAXxuafIRcQo0g7Z8OaUy8vG0J1IURlHnrEOtW5f-wudMqXzmx3jWFvnx-n
    JVEJ-RJ76gEZDwaI_Ya78FZyRBtHTQ6Gde6fTRGX0Iz48_ChwfCQgeT>
X-ME-Received: <xmr:EfddaqmH-V4v4Rv1Q4MHHoFBpJCRDBVuEflGQvTExrErAByxrOJuTlANmnytaVCt6AzIWJT6vj3Vs7S2NYCyJA-VmKmXG1Q>
X-ME-Proxy-Cause: dmFkZTEp/fwrM5nv0l8VHKAyzhHNzx+2eN/oyOXgho+RksB0pdIRUR8TvPitulR6oVgx8I
    PTCIN8jB5p4uOwim83a1ytgBdXWnZbc7fAlIa+Vn3MtbmzW6iPcxJ2hhgiUS/Z/fwqJHMB
    d7wZQfKWjivx1VPYK974+SJ7GbXkvoX46hyqtoPesI4AUjX7qsz6xV60gwEa3aENp/oCR1
    ePKvcUoINckTcNFFgQmvsFhFkNCk7dZWNr+hkGHzYqgdl/QyTEKSjIX2gHpWYaJMlhfV6M
    EltNMlbSvha5coqhgr1uXD2AMy/+2spwkBQ2ElNuENzGl4yOTljPQuo9hENLIe87NmFhJj
    7UXJgIcaEa04NmswFM6bn6ykN+0nGbtv//Y+73/1IgTRWz+z9dKw8HVz7oA9sFWRs/FDQf
    pO89CGi8EemLIpJ1wHTdQz6lX/5i129+xGYiHPKZwyeAwCctNQORxIQto+6c2HkYJ37oeC
    /YXt7oGs0Vh9IXW2fca2tSDeqhPBorRl2J74OAFmP4kr0iopU2KgmtF9m/7lJA5I8v3n4+
    iL1Grmpypy5mmTonNPf+Y4T+PQEFWPdioFmMNnwJjK93HLRtj6oUfGtvx7nIKzMLFGybMQ
    rcu76WHWI6q4SMfUCi6T8IvkvPKOY+dtHvsg1mjYEcvbBgRjwE+AXBNPEpew
X-ME-Proxy: <xmx:EfddavzhxmVlpf6YFaXwlCPAB3F3U35tcftfzuj2ZUxAvxbyofQgmg>
    <xmx:EfddagMezcrWxEop1cu2Bkn-JCya7KiuQ7mSlbKaUkGgETkWIzvJmw>
    <xmx:EfddarRkqISlm6NtJxroYR36Ti_P3O0XaUfsYr6C_Z9-FdUNktmLlg>
    <xmx:EfddamZLsY-aGBA7SRyb4QU7k3R5DIYdPAP-0Da9bpJ3waFc3UWHng>
    <xmx:Efddajy0az26PRQnCAR6lLP4DtnBO9d7ARSre-eCfT1xwyHtyVWNTr7o>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 06:23:12 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Mon, 20 Jul 2026 11:23:06 +0100
Subject: [PATCH pseudo] makewrappers/openat2: Add noignore_path option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-openat2-v1-1-e5f582efeba8@pbarker.dev>
X-B4-Tracking: v=1; b=H4sIAAn3XWoC/yWMwQqDMBAFf0XeuYF0hUb6K6WHaLa6PSQhqyKI/
 25sjzMMs0O5CCuezY7Cq6ikWOF+azBMPo5sJFQGWXpYR9akzNHPZMi7ru1aGwI71DoX/sj2O72
 QlZeQ8P57XfovD/O1wXGcMok5yHMAAAA=
X-Change-ID: 20260720-openat2-2a783830dde7
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=sSFDXNLt7ljWDDD6zcZLJWjkiNYdHjBvYZYSZaj7sgo=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWTFfufhq1iq/uXFh2KlRVM4XBrVn7l0ngjRvrv+0Z43P
 w5L958T7ihlYRDjYpAVU2TZ3PP1/tNeR96MkFsKMHNYmUCGMHBxCsBE/vExMlyuy/7o0New9tut
 zoO6+zv/yvIafc47JW3JKFiQ2zblZyDDH15reaXn+h6HqtUufDy7vdp0Y5v9HZ7luycv0fw467W
 SJTMA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 10:23:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4518

We must always record the path given to an openat2() call, even if it is
ignored. If not, we may later see another openat2() call where dirfd
refers to an unknown directory, which leads to failures like the
following (seen in do_package_write_ipk as the ipk deploy directory is
ignored by pseudo):

    got *at() syscall for unknown directory, fd 4
    unknown base path for fd 4, path python3-sphinxcontrib-devhelp_2.0.0-r0_x86-64-v3.ipk
    couldn't allocate absolute path for 'python3-sphinxcontrib-devhelp_2.0.0-r0_x86-64-v3.ipk'.
    tar: ./x86-64-v3/python3-sphinxcontrib-devhelp_2.0.0-r0_x86-64-v3.ipk: Cannot open: Bad address
    tar: Exiting with failure status due to previous errors

This brings the openat2() wrapper in line with the other open*()
wrappers defined in ports/linux/wrapfuncs.in.

[YOCTO #16316]

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 ports/linux/openat2/wrapfuncs.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ports/linux/openat2/wrapfuncs.in b/ports/linux/openat2/wrapfuncs.in
index 29956464a54d..de1b7dc50b76 100644
--- a/ports/linux/openat2/wrapfuncs.in
+++ b/ports/linux/openat2/wrapfuncs.in
@@ -1 +1 @@
-int openat2(int dirfd, const char *path, const struct open_how *how, size_t size); /* preserve_paths=1 */
+int openat2(int dirfd, const char *path, const struct open_how *how, size_t size); /* preserve_paths=1, noignore_path=1 */

---
base-commit: 823895ba708c63f6ae4dcbfc266210f26c02c698
change-id: 20260720-openat2-2a783830dde7

Best regards,
--  
Paul Barker


