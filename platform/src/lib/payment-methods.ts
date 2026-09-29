import "server-only";

/**
 * Gabriel's own receiving accounts — no payment gateway, he doesn't hold a
 * valid ID for the KYC one would require (2026-09-28). A student pays these
 * directly, then submits the reference number on /upgrade for manual review
 * at /admin/payments. Read server-side only and passed down as props —
 * these aren't secrets (they're exactly what a student needs to pay), but
 * there's no reason to bundle them into client JS either.
 */
export const UPGRADE_PRICE_PHP = 159;

/** Gabriel's own contact info, offered on /upgrade and /signup for a faster manual approval than waiting for the review queue (his explicit request, 2026-09-28 and 2026-09-29). Not a secret -- meant to be shown to students. */
export const FASTER_APPROVAL_CONTACT = {
  facebookUrl: "https://www.facebook.com/ggabdcc",
  tiktokUrl: "https://www.tiktok.com/@ggabdcc",
  phoneNumber: "09606270621",
};

export type PaymentMethodKey = "gcash" | "maya" | "landbank";

export type PaymentMethodInfo = {
  key: PaymentMethodKey;
  label: string;
  accountName: string;
  accountNumber: string;
  configured: boolean;
};

function readAccount(key: PaymentMethodKey, nameVar: string, numberVar: string): PaymentMethodInfo {
  const accountName = process.env[nameVar];
  const accountNumber = process.env[numberVar];
  const configured = Boolean(accountName && accountNumber);
  return {
    key,
    label: key === "gcash" ? "GCash" : key === "maya" ? "Maya" : "Landbank",
    accountName: accountName ?? "Not configured yet",
    accountNumber: accountNumber ?? `Set ${numberVar} in .env.local`,
    configured,
  };
}

export function getPaymentMethods(): PaymentMethodInfo[] {
  return [
    readAccount("gcash", "GCASH_ACCOUNT_NAME", "GCASH_ACCOUNT_NUMBER"),
    readAccount("maya", "MAYA_ACCOUNT_NAME", "MAYA_ACCOUNT_NUMBER"),
    readAccount("landbank", "LANDBANK_ACCOUNT_NAME", "LANDBANK_ACCOUNT_NUMBER"),
  ];
}
