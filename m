Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.161555.1712741392981834916
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Apr 2024 02:29:53 -0700
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso7527831e87.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Apr 2024 02:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712741391; x=1713346191; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0RdsSRE03fLBJbvroJWwoI3VHnNRd8Pv31msWNW7Fs=;
        b=GnfOPVhN4gEqbUacGrB6F0SUBDKW3zX+W+lGIAnUuuj8cVsJFoOkZCxtR8x60T8k5i
         ULAO6mMwM28ouLEzJ/An6o3X/25dJocFgRvN/Rsorh2odo/JBAqGuhJvZC8VtANLkCJM
         jSYG0Ib2kMEC5UzeyP1eJLVd1VGZ3dTskb/tE=
Return-Path: <richard.purdie@linuxfoundation.org>
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/2] fchmodat: Ignore symlinks, don't return an error
Date: Wed, 10 Apr 2024 10:29:48 +0100
Message-Id: <20240410092948.1989389-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20240410092948.1989389-1-richard.purdie@linuxfoundation.org>
References: <20240410092948.1989389-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: openembedded-core@lists.openembedded.org, seebs@seebs.net, mark.hatle@kernel.crashing.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Ugrading to coreutils 9.5 pulls in:
https://git.savannah.gnu.org/cgit/coreutils.git/commit/src/chmod.c?id=07a69fc3ba717b879218592db685a1c79869cb28
which calls fchmodat with AT_SYMLINK_NOFOLLOW.

All the docs I can find say that symlinks don't have modes and are
always readable. With the error in place, we see things like:

chmod: changing permissions of 'XXX/build-appliance-image/15.0.0/rootfs/home/builder/poky/scripts/esdk-tools/runqemu-gen-tapdevs': Function not implemented

when building build-appliance-image, which uses tools from coreutils-native.
It is only a matter of time before distros start shipping those newer tools.

I believe the correct thing to do is just return success here rather
than failure. This does fix the build failure.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/unix/guts/fchmodat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/ports/unix/guts/fchmodat.c b/ports/unix/guts/fchmodat.c
index d1ac7bb..5a31151 100644
--- a/ports/unix/guts/fchmodat.c
+++ b/ports/unix/guts/fchmodat.c
@@ -28,9 +28,8 @@
 		return rc;
 	}
 	if (S_ISLNK(buf.st_mode)) {
-		/* we don't really support chmod of a symlink */
-		errno = ENOSYS;
-		return -1;
+		/* according to docs, "chmod on a symbolic link always succeeds and has no effect" */
+		return 0;
 	}
 	save_errno = errno;
 
-- 
2.40.1

