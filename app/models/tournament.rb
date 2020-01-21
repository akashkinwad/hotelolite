class Tournament < ApplicationRecord

  enum status: [ :upcoming, :ongoing, :concluded ]

  belongs_to :provider
  has_many :matches, dependent: :destroy
  has_and_belongs_to_many :plans
  has_many :subscriptions, through: :plans

  validates :name, presence: true, uniqueness: true
  validates :provider_tournament_id, presence: true
  validate :check_provider_tournament_id

  after_save :create_tournaments_matches, if: :saved_change_to_provider_tournament_id?

  def status_class
    if status == Tournament.statuses.keys[2]
      'kt-badge--danger'
    elsif status == Tournament.statuses.keys[1]
      'kt-badge--primary'
    else
      'kt-badge--success'
    end
  end

  def tournaments_matches(tournament_id)
    @tournament ||= ArenasService.tournament(tournament_id)
    @tournament['matches']
  end

  def tournament_matches_available?
    matches = tournaments_matches(self.provider_tournament_id)
    matches.present? ? true : false
  end

  private

    def check_provider_tournament_id
      unless tournament_matches_available?
        errors.add(:provider_tournament_id, "ID is invalid")
      end
    end

    def create_tournaments_matches
      matches = tournaments_matches(self.provider_tournament_id)
      matches.each do |match|
        self.matches.create(
          title: match['match']['title'],
          provider_id:  match['match']['id']
        )
      end
    end
end
