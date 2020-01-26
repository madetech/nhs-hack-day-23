module UseCase
  class ViewRecommendations
    def execute(*)
      { recommendations: [
        {
          title: 'Walking Group',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
        },
        {
          title: 'Tai Chi',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'

        }
      ] }
    end
  end
end
