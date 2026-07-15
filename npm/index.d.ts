declare module '@apiverve/imagetotext' {
  export interface imagetotextOptions {
    api_key: string;
    secure?: boolean;
  }

  /**
   * Describes fields the current plan does not unlock. Locked fields arrive as null
   * in `data`; `locked_fields` names them, using dot paths for nested fields.
   * Absent when the plan unlocks everything.
   */
  export interface PremiumInfo {
    message: string;
    upgrade_url: string;
    locked_fields: string[];
  }

  export interface imagetotextResponse {
    status: string;
    error: string | null;
    data: ImagetoTextData;
    code?: number;
    premium?: PremiumInfo;
  }


  interface ImagetoTextData {
      text:       null | string;
      confidence: number | null;
      words:      number | null;
      characters: number | null;
      lines:      number | null;
  }

  export default class imagetotextWrapper {
    constructor(options: imagetotextOptions);

    execute(callback: (error: any, data: imagetotextResponse | null) => void): Promise<imagetotextResponse>;
    execute(query: Record<string, any>, callback: (error: any, data: imagetotextResponse | null) => void): Promise<imagetotextResponse>;
    execute(query?: Record<string, any>): Promise<imagetotextResponse>;
  }
}
