Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED23210F9300
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 20:42:03 +0000 (UTC)
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1043.1774989722057885236
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 31 Mar 2026 13:42:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=ZDqdBGIj;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=uga3R8WZ;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.150, mailfrom: paul@pbarker.dev)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A898EC0103;
	Tue, 31 Mar 2026 16:42:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 31 Mar 2026 16:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1774989721; x=1775076121; bh=CC
	ZxLP16bOCa4H62rHR+MAEGMfjchXXfbbuIHSi0RYk=; b=ZDqdBGIjUqJiTw7p1O
	me22Ob5Xq6R17SZfYYKYDPDSflV8hzJ2mPalGM6er71eOqS4Grt7K+0H7NEpsQS9
	mDP2y0qF3LgiRLJhnRVein9QNSBMmQhI/L/y9o0FVTimZskMG0+uxAraAQhvQQTy
	+C9MgHtOsIdtLq9ujhY4iLZV1NceMPEDqBFU7o0wnxoudIYKWtIdp9/GMSctW5pS
	ZPDDHrTzVEkOsAFSeuHfsVeS9Wry/PepXcQrQz18X4qAitnujWqyk06B5VnW8LEL
	7V2q2R+r+ghFP/+d0pr+oJZBfuNXramtwKj1GznFKKmvOKeY1+j4wAI47QP21Fuc
	CyZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1774989721; x=1775076121; bh=CCZxLP16bOCa4H62rHR+MAEGMfjc
	hXXfbbuIHSi0RYk=; b=uga3R8WZBG4gRk1pOFm0Gy1BJ+o1+dNtCsVdBAMnNRkZ
	4/tiEtXjtpFimL+hE0c8XdJMqFdwuICcdFHESOkNm6Ea0WTOj+qxr5ka4n8spAxY
	rS1dJGPaPclyCuM6nvERTRIgamreqAQ+vVC+DdlQUAfpe0h/BWdFQPyxKVcShur3
	cHpRJUalw9Hx6YZCVCJrAAAzmSZE//Za5K6Fi7zoIQkFicx9srkthit0H23Nfz6k
	Nlu+eU8pB2mf53RjOxjkHk0LzyIv9J/E3mmIOJBu3NF8faBsrBKO0wQdsofBTkxB
	89GoxMmhhTGJO+iUq3jYFh5PUow0BSqLXGsMwxZZMw==
X-ME-Sender: <xms:mDHMaa_wHghLNXnGCgbjHvMZB-H2EXwPiZs3x-KzveEU9Y3M3OInLg>
    <xme:mDHMaQtUUb26DCV7-xv5qDhqopMu6GWl3D82lHjjiVPwG6JM8nQNMJpeckAuhJfeD
    ohdUQVY_UhOixnxS4C80q2XCvx0i-LbNdvSDQ_StVbI5z_c4oVwKw>
X-ME-Received: <xmr:mDHMadqgj-WnVM8LFUGUoLv3ysZqO3IUL1iwkO2XIAanLl0WeBPT7SSpg0dnn_Gmt6c7DIXzzjV1Bu8-7ycYqhDvjlyXJvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkvfevofesthejredtredtje
    enucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggv
    vheqnecuggftrfgrthhtvghrnhepjeelteefleetkeduueefteffgeeltdeguefgveette
    ekveetieektdfftedtkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhope
    dvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhesphgsrghrkhgvrhdr
    uggvvhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtth
    hophhrohhjvggtthdrohhrgh
X-ME-Proxy: <xmx:mDHMadmhfUVvItL-xHLbnRlhAoZSj0y4vibS92Cb7WvXsCwnLT4WSA>
    <xmx:mDHMaRxducFDmjkikEQSU6LhWBKSMcQ7xYU79T8MF9BeAYBWleGq8A>
    <xmx:mDHMaVm4-8DkB_10Y0CRz7UUuL_983yALWbw-dNuLMydJQxQFoadbw>
    <xmx:mDHMaacmbk4oggPhnUFXjVzfX3g6im1AHlgjUQ3sTTybtN2gFnSMBg>
    <xmx:mTHMaWhjsIUOcxpQOrBG3i5e5NQb2eGkIg7k_x8ujtFskUFYAIsPGq3Z>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 16:42:00 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Tue, 31 Mar 2026 21:41:57 +0100
Subject: [PATCH yocto-autobuilder-helper] config.json: Use buildtools on
 RHEL9 derivatives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-rhel9-v1-1-e5c2cf815386@pbarker.dev>
X-B4-Tracking: v=1; b=H4sIAJQxzGkC/yWMzQrCMBAGX6Xs2UDSxt9XEQ9p8tWulKZsElFK3
 92ox4GZWSlBGIkuzUqCJyeOcwWza8iPbr5DcahMrW4PuuuMkhHTWQWY48nuB2etpuougoFfv8+
 V3tHnqFzJsS88BYiqzQKh299MpX/A5++Wtu0DepCwi4MAAAA=
X-Change-ID: 20260331-rhel9-de17845fa440
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=mY/8MDQTOsZOeW3bIyuOlB2FNzjdWUMCg5vMcUAPXeI=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWSeMZzRyR3l6nqzKezb3gnJLwMWX3ymtqN9o1XugkjJZ
 juFO1kvO0pZGMS4GGTFFFk293y9/7TXkTcj5JYCzBxWJpAhDFycAjCRd8cZ/odt3SmW6PaoSjrv
 heotDqY9PztLN2S29VwofeESv7LiTjEjw/Q1e+YEXuZedOpXrstWL9v1FW5tc9fO+iA1d16Z35b
 l3uwA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 31 Mar 2026 20:42:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3591

tar 1.34 (and possibly earlier versions) is unable to extract tarballs
containing read-only files with xattrs. This was fixed upstream, but
it's unlikely at this point that the fix will be backported to RHEL9
related distros (CentOS Stream 9, AlmaLinux 9, Rocky Linux 9). The issue
affects these distros specifically because they have selinux enabled by
default and this uses xattrs.

The specific failure we've seen is with the /usr/lib/udev/hwdb.bin file
installed by the systemd recipe - this file is chmod 0444. This leads to
the following error, typically during do_image_wic (shortened and split
to make it readable):

    subprocess.CalledProcessError: Command
    'tar --xattrs --xattrs-include='*' -cf - -S -C .../tmp/work/qemux86_64-poky-linux/core-image-minimal/1.0/rootfs -p . |
    tar --xattrs --xattrs-include='*' -xf - -C .../tmp/work/qemux86_64-poky-linux/core-image-minimal/1.0/tmp-wic/rootfs2'
    returned non-zero exit status 2.

To work around this, we will need to use the buildtools tarball on
affected systems.

Fixes [YOCTO #16143].

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 config.json | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.json b/config.json
index 0902e8620b0d..f0ea2e75e124 100644
--- a/config.json
+++ b/config.json
@@ -2006,6 +2006,9 @@
         "alma8*"       : "${BUILDTOOLS_URL}",
         "rocky8*"      : "${BUILDTOOLS_URL}",
         "stream8*"     : "${BUILDTOOLS_URL}",
+        "alma9*"       : "${BUILDTOOLS_URL}",
+        "rocky9*"      : "${BUILDTOOLS_URL}",
+        "stream9*"     : "${BUILDTOOLS_URL}",
         "opensuse154*" : "${BUILDTOOLS_URL}",
         "opensuse155*" : "${BUILDTOOLS_URL}",
         "opensuse156*" : "${BUILDTOOLS_URL}",

---
base-commit: 85905638be7b50e594d210e2aa64a6809df43c1b
change-id: 20260331-rhel9-de17845fa440

Best regards,
--  
Paul Barker


